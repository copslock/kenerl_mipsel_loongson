Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 06:40:30 +0000 (GMT)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:55177 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225011AbUKWGkV>; Tue, 23 Nov 2004 06:40:21 +0000
Received: from fallout.sjc.foobazco.org (fallout.sjc.foobazco.org [192.168.21.20])
	by mail.foobazco.org (Postfix) with ESMTP
	id 46D1F50D7; Mon, 22 Nov 2004 22:40:12 -0800 (PST)
Received: by fallout.sjc.foobazco.org (Postfix, from userid 1014)
	id 1EEA227CAF; Mon, 22 Nov 2004 22:40:12 -0800 (PST)
Date: Mon, 22 Nov 2004 22:40:12 -0800
From: Keith M Wesolowski <wesolows@foobazco.org>
To: agx@sigxcpu.org
Cc: linux-mips@linux-mips.org
Subject: PATCH: arcboot cache
Message-ID: <20041123064011.GA17752@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

Let's make arcboot 20x faster, shall we?  Tested on ip22, ip32.

diff -urN arcboot-0.3.8.4/e2fslib/bitops.h arcboot-working/e2fslib/bitops.h
--- arcboot-0.3.8.4/e2fslib/bitops.h	2002-02-03 14:53:42.000000000 -0800
+++ arcboot-working/e2fslib/bitops.h	2004-11-22 12:56:19.000000000 -0800
@@ -410,6 +410,9 @@
 #endif /* !_EXT2_HAVE_ASM_SWAB */
 
 #if !defined(_EXT2_HAVE_ASM_FINDBIT_)
+
+extern int ffs(int);
+
 _INLINE_ int ext2fs_find_first_bit_set(void * addr, unsigned size)
 {
 	char	*cp = (unsigned char *) addr;
diff -urN arcboot-0.3.8.4/ext2load/arcboot.h arcboot-working/ext2load/arcboot.h
--- arcboot-0.3.8.4/ext2load/arcboot.h	2003-04-26 12:51:15.000000000 -0700
+++ arcboot-working/ext2load/arcboot.h	2004-11-21 23:34:36.000000000 -0800
@@ -21,5 +21,6 @@
 CHAR** ReadConfFile(char **partition, const char *filename, char* config);
 
 /* ext2io.c */
+extern int arc_do_progress;
 void print_ext2fs_error(long status);
 #endif /* _ARCBOOT_H */
diff -urN arcboot-0.3.8.4/ext2load/ext2io.c arcboot-working/ext2load/ext2io.c
--- arcboot-0.3.8.4/ext2load/ext2io.c	2004-03-01 03:24:04.000000000 -0800
+++ arcboot-working/ext2load/ext2io.c	2004-11-22 21:03:25.000000000 -0800
@@ -18,15 +18,115 @@
 #include <ext2fs.h>
 #include <arc.h>
 
+/*
+ * All About the Cache
+ *
+ * Without this cache, reading is horribly slow - it can take 30-60 seconds
+ * (or even more) to read a kernel.  While this is a bootloader and we only
+ * do it once, that's still a very long time for the user to sit there with
+ * nothing happening (a progress indicator has also been added).  The
+ * read workload looks like this: reads of the inode and indirection blocks
+ * interleaved with single-block reads of what are essentially contiguous
+ * regions of data blocks.  As a concrete example, we might see:
+ *
+ * 100, 200, 100, 201, 100, 202, 100, 101, 203, 100, 101, 204, ...
+ *
+ * Therefore we could simply cache the last 4 or so blocks and get an
+ * immediate 50-67% speedup with minimal waste.  However, it's possible to
+ * do better - in fact, a lot better.  The ARCS calls are so expensive that
+ * it's worthwhile also to try doing readahead.  Unless the filesystem is
+ * horribly fragmented, this will up our hit ratio to at least 85% or so
+ * with just 16 cache blocks (in fact if the fs is 0% fragmented, we could
+ * see 99% hits on the indirection blocks and about 92% on the data blocks,
+ * or about 96% overall! - even 80% would be adequate however).
+ *
+ * We really have two caches: a traditional LRU single-block cache, and a
+ * readahead multiblock scatter/gather cache.  They are however unified to
+ * speed lookup.  CACHE_SIZE is the total number of cacheable blocks, and
+ * CACHE_SG_MAX is the maximum size of a s/g request.  The overall
+ * implementation is based on the one in unix_io, but has a lot of changes
+ * to accomodate readahead.
+ *
+ * Lookup is straightforward: the cache is fully associative, so we do a
+ * linear search for the requested block number (it is only possible to
+ * search for one block at a time).  Alloc requests are handled differently.
+ * We start with the age of the oldest block and work newer until we have
+ * enough blocks to satisfy the sg request.  These blocks have their bufs
+ * point into the per-cache arc_sg_buf and the number of successfully allocated
+ * blocks is then returned after invalidating each allocated cache block and
+ * recording the block it will reference.  A later call to fill_sg_blocks
+ * will perform a single read to fill the entire cache "line."
+ *
+ * When any sg cache block is reused, the sg cached data is first copied into
+ * the per-cache buffer for all sg cache blocks, and then all buffer pointers
+ * in the sg cache blocks are reset.  Note that we only do this for the
+ * cache blocks we aren't going to immediately reuse.
+ *
+ * We don't have any reliable replacement for time(2), so instead we just use
+ * a monotonically increasing counter incremented by any function that looks
+ * into the cache.  We do risk overflow, but if we do 2**32 cache lookups
+ * the machine has probably failed to do anything useful anyway.
+ *
+ * Important: there are two large simplifying assumptions here:
+ * (1) The filesystem is universally read-only.  There are no other processes
+ *     which can write to this filesystem on this or any remote system.
+ * (2) We are single-threaded.
+ *
+ * As such, we do not have code here to handle locking, coherency, or aliases.
+ * This is fine for a bootloader but dangerous in other situations.  If
+ * ARC_IO_ALLOW_WRITE is enabled (it's off by default), then on any write will
+ * the cache will act as write-through, and the entire cache will be
+ * invalidated.  This is the most naive correct implementation.  If writing
+ * becomes an important task, this will need to be revisited; the unix_io
+ * writeback cache is a good starting point.
+ */
+
+#define CACHE_SIZE	16
+#define CACHE_SG_MAX	12
+
+#define CACHE_IS_SG(_cache)	((_cache)->buf != (_cache)->alloc_buf)
+
+struct arc_cache {
+	char		*buf;
+	char		*alloc_buf;
+	unsigned long	block;
+	int		last_use;
+	int		in_use:1;
+};
+
+static struct arc_cache *sg_cblocks[CACHE_SG_MAX];
+static unsigned long virtual_time;
 
 struct arc_private_data {
-	int magic;
-	OPENMODE mode;
-	ULONG fileID;
+	int			magic;
+	OPENMODE		mode;
+	ULONG			fileID;
+	struct arc_cache	cache[CACHE_SIZE];
+	char			*arc_sg_buf;
+	unsigned long		total_read;
+	unsigned long		seek_pos;
+	int			seek_pos_valid:1;
 };
 
-static errcode_t arc_open(const char *name, int flags,
-			  io_channel * channel);
+static void arc_progress(struct arc_private_data *, unsigned long);
+
+static errcode_t alloc_cache(io_channel, struct arc_private_data *);
+static void free_cache(io_channel, struct arc_private_data *);
+static void reset_one_cache(io_channel, struct arc_private_data *,
+    struct arc_cache *, int);
+static void reset_sg_cache(io_channel, struct arc_private_data *, int);
+static struct arc_cache *find_cached_block(io_channel,
+    struct arc_private_data *, unsigned long);
+static int alloc_sg_blocks(io_channel, struct arc_private_data *,
+    unsigned long, int);
+static errcode_t fill_sg_blocks(io_channel, struct arc_private_data *, int);
+
+static errcode_t raw_read_blk(io_channel, struct arc_private_data *,
+    unsigned long, int, char *);
+static void mul64(unsigned long, int, LARGEINTEGER *);
+static errcode_t arc_seek(io_channel, unsigned long);
+
+static errcode_t arc_open(const char *name, int flags, io_channel * channel);
 static errcode_t arc_close(io_channel channel);
 static errcode_t arc_set_blksize(io_channel channel, int blksize);
 static errcode_t arc_read_blk
@@ -47,6 +147,299 @@
 };
 io_manager arc_io_manager = &struct_arc_manager;
 
+int arc_do_progress = 0;
+
+static int hits, misses;
+
+static void
+arc_progress(struct arc_private_data *priv, unsigned long count)
+{
+	int hitrate_w = (hits * 1000) / (hits + misses) / 10;
+	int hitrate_f = (hits * 1000) / (hits + misses) % 10;
+
+	priv->total_read += count;
+	printf("\r%lx      (cache: %u.%u%%)", priv->total_read, hitrate_w,
+	    hitrate_f);
+
+#ifdef DEBUG
+	if ((hits + misses) % 100 == 0)
+		printf("hits: %u misses %u\n\r", hits, misses);
+#endif
+}
+
+/*
+ * Allocates memory for a single file's cache.
+ */
+static errcode_t
+alloc_cache(io_channel channel, struct arc_private_data *priv)
+{
+	errcode_t		status;
+	struct arc_cache	*cache;
+	int			i;
+
+	for(i = 0, cache = priv->cache; i < CACHE_SIZE; i++, cache++) {
+		memset(cache, 0, sizeof (struct arc_cache));
+		if ((status = ext2fs_get_mem(channel->block_size,
+		    (void **) &cache->alloc_buf)) != 0)
+			return (status);
+		cache->buf = cache->alloc_buf;
+	}
+
+	return (ext2fs_get_mem(channel->block_size * CACHE_SG_MAX,
+	    (void **) &priv->arc_sg_buf));
+}
+
+/*
+ * Frees all memory associated with a single file's cache.
+ */
+static void
+free_cache(io_channel channel, struct arc_private_data *priv)
+{
+	struct arc_cache	*cache;
+	int			i;
+
+	for (i = 0, cache = priv->cache; i < CACHE_SIZE; i++, cache++) {
+		if (cache->alloc_buf)
+			ext2fs_free_mem((void **) &cache->alloc_buf);
+		memset(cache, 0, sizeof (struct arc_cache));
+	}
+
+	ext2fs_free_mem((void **) &priv->arc_sg_buf);
+}
+
+/*
+ * Resets a cache block.  If the cache block is a valid sg block, the contents
+ * will be copied from the sg buffer into the private buffer.  For all blocks,
+ * the private buffer will be current.  If discard is set, the block will
+ * also be invalidated.
+ */
+static void
+reset_one_cache(io_channel channel, struct arc_private_data *priv,
+    struct arc_cache *cache, int discard)
+{
+	if (CACHE_IS_SG(cache) && discard == 0 && cache->in_use != 0)
+		memcpy(cache->alloc_buf, cache->buf, channel->block_size);
+
+	if (discard != 0)
+		cache->in_use = 0;
+
+	cache->buf = cache->alloc_buf;
+}
+
+/*
+ * Resets all sg cache blocks.  If a block is in the first
+ * alloc_count entries in sg_cblocks (meaning it has been allocated for
+ * immediate reuse) then also discards the contents.
+ */
+static void
+reset_sg_cache(io_channel channel, struct arc_private_data *priv,
+    int alloc_count)
+{
+	struct arc_cache	*cache;
+	int			i, j, discard;
+
+	for (i = 0, cache = priv->cache; i < CACHE_SIZE; i++, cache++) {
+		if (CACHE_IS_SG(cache)) {
+			discard = 0;
+			for (j = 0; j < alloc_count; j++) {
+				if (sg_cblocks[j] == cache) {
+					discard = 1;
+					break;
+				}
+			}
+			reset_one_cache(channel, priv, cache, discard);
+		}
+	}
+}
+
+/*
+ * Read count blocks starting at block directly from channel into buf, which
+ * must be of size >= channel->block_size * count.  No attempt is made to
+ * use or update any caches; however, if the last ARC read left the file
+ * pointer at the requested block, we avoid seeking.
+ */
+static errcode_t
+raw_read_blk(io_channel channel, struct arc_private_data *priv,
+    unsigned long block, int count, char *buf)
+{
+	errcode_t	status;
+	size_t		length = 0;
+
+	if (priv->seek_pos_valid == 0 || priv->seek_pos != block) {
+		status = arc_seek(channel, block);
+		priv->seek_pos = block + count;
+	} else {
+		status = 0;
+	}
+	/* If something fails, priv->seek_pos is bogus. */
+	priv->seek_pos_valid = 0;
+	if (status == 0) {
+		length = (count < 0) ? -count : count * channel->block_size;
+		ULONG nread = 0;
+
+		status = ArcRead(priv->fileID, buf, length, &nread);
+		if ((nread > 0) && (nread < length)) {
+			status = EXT2_ET_SHORT_READ;
+			memset(((char *) buf) + nread, 0, length - nread);
+		}
+		if (status != 0 && channel->read_error != NULL) {
+			status = (channel->read_error)
+			    (channel, block, count, buf, length, nread, status);
+		}
+	} else {
+		status = EXT2_ET_BAD_BLOCK_NUM;
+	}
+
+	if (status == 0) {
+		priv->seek_pos_valid = 1;
+		if (arc_do_progress != 0)
+			arc_progress(priv, (unsigned long) length);
+	}
+
+	return (status);
+}
+
+/*
+ * For the file associated with channel and priv, find block in the cache.
+ * In the case of a miss, return NULL.  The last access "time" will be
+ * updated to refresh the LRU.  Note that this is much different from the
+ * unix_io.c version of the same function; because our allocation step is
+ * far more complex to cover readahead, it is dealt with in alloc_sg_blocks.
+ */
+static struct arc_cache *
+find_cached_block(io_channel channel, struct arc_private_data *priv,
+    unsigned long block)
+{
+	struct arc_cache	*cache;
+	int			i;
+
+	++virtual_time;
+
+	for (i = 0, cache = priv->cache; i < CACHE_SIZE; i++, cache++)
+		if (cache->block == block) {
+			cache->last_use = virtual_time;
+			++hits;
+			return (cache);
+		}
+
+	++misses;
+	return (NULL);
+}
+
+/*
+ * Allocate a set of cache blocks whose buffers are contiguous.  The cache
+ * blocks are found in sg_cblocks.  The number of allocated blocks is the
+ * return value; a return value of 0 indicates an error.  The cache blocks
+ * are not filled here; use fill_sg_blocks for that.
+ */
+static int
+alloc_sg_blocks(io_channel channel, struct arc_private_data *priv,
+    unsigned long block, int count)
+{
+	struct arc_cache	*cache, *oldest_cache;
+	int			i, unused_count, age_mark;
+
+	if (count > CACHE_SG_MAX)
+		count = CACHE_SG_MAX;
+
+	++virtual_time;
+	oldest_cache = NULL;
+	unused_count = 0;
+
+	/* First use unused blocks, if any are available. */
+	for (i = 0, cache = priv->cache; i < CACHE_SIZE && unused_count < count;
+	    i++, cache++) {
+		if (cache->in_use == 0) {
+			sg_cblocks[unused_count++] = cache;
+			continue;
+		}
+		if (!oldest_cache || cache->last_use < oldest_cache->last_use)
+			oldest_cache = cache;
+	}
+
+	/* If we don't have enough blocks yet, evict the LRUs. */
+	if (unused_count < count) {
+		for (age_mark = oldest_cache->last_use;
+		    unused_count < count && age_mark <= virtual_time;
+		    age_mark++) {
+			for (i = 0, cache = priv->cache;
+			    i < CACHE_SIZE && unused_count < count;
+			    i++, cache++) {
+				if (cache->in_use == 0)
+					continue;
+				if (cache->last_use == age_mark)
+					sg_cblocks[unused_count++] = cache;
+			}
+		}
+	}
+
+	/*
+	 * At this point it's impossible not to have count blocks.  However,
+	 * even if we somehow don't, it's not fatal - perhaps someone
+	 * decided to use some future lru timestamp to lock an entry or
+	 * something.  In this case, we just continue on, and make sure the
+	 * caller knows we didn't allocate as much as was requested.
+	 */
+
+	/*
+	 * Now we set up the cache blocks.  Their buffers need to be
+	 * set to the sg buffer and they must be marked invalid (we will
+	 * mark them valid once fill_sg_blocks fills them).
+	 */
+	reset_sg_cache(channel, priv, count);
+
+	for (i = 0; i < count; i++) {
+		cache = sg_cblocks[i];
+		cache->in_use = 0;
+		cache->block = block + i;
+		cache->buf = priv->arc_sg_buf + i * channel->block_size;
+	}
+
+	return (count);
+}
+
+/*
+ * Fill the first count cache blocks in sg_cblocks with contiguous data from
+ * the file.  The block numbers are already stored in the cache metadata
+ * by a mandatory previous call to alloc_sg_blocks.  This can fail if there
+ * is an i/o error.
+ */
+static errcode_t
+fill_sg_blocks(io_channel channel, struct arc_private_data *priv, int count)
+{
+	errcode_t	status;
+	int		i;
+
+	status = raw_read_blk(channel, priv, sg_cblocks[0]->block, count,
+	    priv->arc_sg_buf);
+
+	/*
+	 * XXX Handle short read here: it may be that we've reached EOF and
+	 * can mark some of the blocks valid.
+	 */
+	if (status == 0) {
+		for (i = 0; i < count; i++) {
+			sg_cblocks[i]->in_use = 1;
+			sg_cblocks[i]->last_use = virtual_time;
+		}
+	}
+
+	return (status);
+}
+
+/*
+ * Mark the entire contents of the cache invalid, and reset any sg blocks
+ * to private buffers.
+ */
+static void
+cache_invalidate(io_channel channel, struct arc_private_data *priv)
+{
+	struct arc_cache	*cache;
+	int			i;
+
+	for (i = 0, cache = priv->cache; i < CACHE_SIZE; i++, cache++)
+		reset_one_cache(channel, priv, cache, 1);
+}
 
 static errcode_t
 arc_open(const char *name, int flags, io_channel * pchannel)
@@ -84,6 +477,8 @@
 			    ext2fs_get_mem(sizeof(struct arc_private_data),
 					   (void **) &priv);
 			if (status == 0) {
+				memset(priv, 0,
+				    sizeof(struct arc_private_data));
 				channel->private_data = priv;
 				priv->magic = EXT2_ET_BAD_MAGIC;
 				priv->mode =
@@ -99,6 +494,9 @@
 		}
 	}
 
+	if (status == 0)
+		status = alloc_cache(channel, priv);
+
 	if (status == 0) {
 		*pchannel = channel;
 	} else if (channel != NULL) {
@@ -123,12 +521,14 @@
 
 	if (--channel->refcount == 0) {
 		status = ArcClose(priv->fileID);
+		free_cache(channel, priv);
 		if (channel->name != NULL)
 			ext2fs_free_mem((void **) &channel->name);
 		if (channel->private_data != NULL)
 			ext2fs_free_mem((void **) &channel->private_data);
 		ext2fs_free_mem((void **) &channel);
 	}
+
 	return status;
 }
 
@@ -136,18 +536,23 @@
 static errcode_t arc_set_blksize(io_channel channel, int blksize)
 {
 	struct arc_private_data *priv;
+	errcode_t		status;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	priv = (struct arc_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(priv, EXT2_ET_BAD_MAGIC);
 
-	if (channel->block_size != blksize)
+	if (channel->block_size != blksize) {
 		channel->block_size = blksize;
+		free_cache(channel, priv);
+		if ((status = alloc_cache(channel, priv)) != 0)
+			return (status);
+	}
 	return 0;
 }
 
-
-void mul64(unsigned long block, int blocksize, LARGEINTEGER * result)
+static void
+mul64(unsigned long block, int blocksize, LARGEINTEGER *result)
 {
 	ULONG m1l = block & 0x0FFFF, m1h = (block >> 16) & 0x0FFFF;
 	ULONG m2l = blocksize & 0x0FFFF, m2h = (blocksize >> 16) & 0x0FFFF;
@@ -162,8 +567,8 @@
 	result->HighPart += (i1 >> 16) & 0x0FFFF;
 }
 
-
-static errcode_t arc_seek(io_channel channel, unsigned long block)
+static errcode_t
+arc_seek(io_channel channel, unsigned long block)
 {
 	struct arc_private_data *priv;
 	LARGEINTEGER position;
@@ -173,42 +578,103 @@
 	return ArcSeek(priv->fileID, &position, SeekAbsolute);
 }
 
-
+/*
+ * Perform a cacheable read.  First, the cache will be checked for an
+ * existing copy of the blocks.  If present, they are copied into buf.
+ * Otherwise, we set up and execute a readahead, then copy the results into
+ * buf.  The unix_io way is a little nicer; since it doesn't have readahead
+ * it knows that buf is always big enough in multicount scenarios and thus
+ * dispenses with the extra memcpy.  There is an opportunity to improve this.
+ */
 static errcode_t
 arc_read_blk(io_channel channel, unsigned long block, int count, void *buf)
 {
 	struct arc_private_data *priv;
-	errcode_t status;
+	errcode_t		status = 0;
+	struct arc_cache	*cache;
+	char			*cbuf = (char *) buf;
+	int			cb_alloc;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	priv = (struct arc_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(priv, EXT2_ET_BAD_MAGIC);
 
-	status = arc_seek(channel, block);
-	if (status == 0) {
-		size_t length =
-		    (count < 0) ? -count : count * channel->block_size;
-		ULONG nread = 0;
+#ifdef DEBUG
+	printf("req %lu id %lu count %u\n\r", block, priv->fileID, count);
+#endif
+
+	/* Odd-sized reads can't be cached. */
+	if (count < 0)
+		status = raw_read_blk(channel, priv, block, count, cbuf);
+
+	while (count > 0) {
+		if ((cache = find_cached_block(channel, priv, block)) == NULL)
+			break;
+#ifdef DEBUG
+		printf("Cache hit on block %lu\n\r", block);
+#endif
+		memcpy(cbuf, cache->buf, channel->block_size);
+		count--;
+		block++;
+		cbuf += channel->block_size;
+	}
 
-		status = ArcRead(priv->fileID, buf, length, &nread);
-		if ((nread > 0) && (nread < length)) {
-			status = EXT2_ET_SHORT_READ;
-			memset(((char *) buf) + nread, 0, length - nread);
+	/*
+	 * Cache miss.  Although it could be that there's just a hole
+	 * in the cache, it's far more likely and easier to handle
+	 * that we've reached the end of a readahead blockset.  Thus
+	 * we just stop looking in the cache for the rest until after
+	 * we do a readahead.  We could try to put in some
+	 * heuristics here to avoid trashing the cache unnecessarily
+	 * for reads we expect are not part of a sequential set.
+	 */
+	while (count > 0) {
+#ifdef DEBUG
+		printf("Cache miss on block %lu (readahead %u)\n\r",
+		    block, CACHE_SG_MAX);
+#endif
+		if ((cb_alloc = alloc_sg_blocks(channel, priv, block,
+		    CACHE_SG_MAX)) == 0) {
+#ifdef DEBUG
+			printf("%s\n\r", "Cache error: can't alloc any blocks");
+#endif
+			/* Cache is broken, so do the raw read. */
+			cache_invalidate(channel, priv);
+			status = raw_read_blk(channel, priv, block, count,
+			    cbuf);
+			break;
 		}
-		if ((status != ESUCCESS) && (channel->read_error != NULL)) {
-			status = (channel->read_error)
-			    (channel, block, count, buf, length, nread, status);
+
+		if ((status = fill_sg_blocks(channel, priv, cb_alloc)) != 0) {
+#ifdef DEBUG
+			printf("Cache error (status %lu at block %lu(%u)\n\r",
+			    (unsigned long) status, block, count);
+#endif
+			/* Cache is broken, so do the raw read. */
+			cache_invalidate(channel, priv);
+			status = raw_read_blk(channel, priv, block, count,
+			    cbuf);
+			break;
 		}
-	} else {
-		status = EXT2_ET_BAD_BLOCK_NUM;
+
+		if (cb_alloc >= count) {
+			memcpy(cbuf, priv->arc_sg_buf,
+			    count * channel->block_size);
+			return (0);
+		}
+
+		memcpy(cbuf, priv->arc_sg_buf, cb_alloc * channel->block_size);
+		count -= cb_alloc;
+		block += cb_alloc;
+		cbuf += cb_alloc * channel->block_size;
 	}
-	return status;
-}
 
+	return (status);
+}
 
 static errcode_t
-    arc_write_blk
-    (io_channel channel, unsigned long block, int count, const void *buf) {
+arc_write_blk (io_channel channel, unsigned long block, int count,
+    const void *buf) {
 	struct arc_private_data *priv;
 	errcode_t status;
 
@@ -218,6 +684,8 @@
 
 	status = arc_seek(channel, block);
 #ifdef ARC_IO_ALLOW_WRITE
+	cache_invalidate(channel, priv);
+	priv->seek_pos_valid = 0;
 	if (status == 0) {
 		size_t length =
 		    (count < 0) ? -count : count * channel->block_size;
@@ -287,7 +755,7 @@
 
 void print_ext2fs_error(long error)
 {
-	char* msg;
+	const char* msg;
 
 	msg = ext2fs_strerror(error);
 	if(msg)
diff -urN arcboot-0.3.8.4/ext2load/loader.c arcboot-working/ext2load/loader.c
--- arcboot-0.3.8.4/ext2load/loader.c	2004-09-25 13:53:52.000000000 -0700
+++ arcboot-working/ext2load/loader.c	2004-11-22 21:05:43.000000000 -0800
@@ -18,6 +18,7 @@
 #include <ext2fs.h>
 
 #include <asm/addrspace.h>
+#include <asm/mipsregs.h>
 #include "arcboot.h"
 
 #include <subarch.h>
@@ -242,10 +243,13 @@
 				    Fatal("Cannot seek to program segment\n\r");
 			    }
 
+			    arc_do_progress = 1;
 			    status = ext2fs_file_read(file,
 						  (void *) (KSEG0ADDR(
 						            segment->p_vaddr)),
 						  segment->p_filesz, NULL);
+			    printf("\n\n\r");	/* Clear progress */
+			    arc_do_progress = 0;
 			    if (status != 0) {
 				print_ext2fs_error(status);
 				Fatal("Cannot read program segment\n\r");
@@ -289,10 +293,12 @@
 				    Fatal("Cannot seek to program segment\n\r");
 			    }
 
+			    arc_do_progress = 1;
 			    status = ext2fs_file_read(file,
 						  (void *) (KSEG0ADDR(
 						            segment->p_vaddr)),
 						  segment->p_filesz, NULL);
+			    arc_do_progress = 0;
 			    if (status != 0) {
 				print_ext2fs_error(status);
 				Fatal("Cannot read program segment\n\r");


-- 
Keith M Wesolowski
"Site launched. Many things not yet working." --Hector Urtubia
