Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8T1s4k26286
	for linux-mips-outgoing; Fri, 28 Sep 2001 18:54:04 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8T1rjD26277
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 18:53:45 -0700
Received: from localhost (bradb@localhost)
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f8T1oFg12708;
	Fri, 28 Sep 2001 18:50:23 -0700
X-Authentication-Warning: earth.ayrnetworks.com: bradb owned process doing -bs
Date: Fri, 28 Sep 2001 18:50:15 -0700 (PDT)
From: Brad Bozarth <prettygood@cs.stanford.edu>
X-X-Sender:  <bradb@earth.ayrnetworks.com>
Reply-To: <prettygood@cs.stanford.edu>
To: <linux-kernel@vger.linux.org>
cc: <torvalds@transmeta.com>, <linux-mips@oss.sgi.com>
Subject: [patch] updated big-endian mkcramfs/cramfs
Message-ID: <Pine.LNX.4.33.0109281843480.11173-100000@earth.ayrnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is against 2.4.10 and fixes issues brought up about the first patch.
It also fixes error handling in one section of mkcramfs where a fd is not
checked after open.

-Brad Bozarth

-------------------------------------------------

--- 2.4.10/scripts/cramfs/mkcramfs.c	Thu Jul 19 16:14:53 2001
+++ current/scripts/cramfs/mkcramfs.c	Fri Sep 28 18:37:45 2001
@@ -317,19 +317,20 @@
 		offset += opt_pad;
 	}

-	super->magic = CRAMFS_MAGIC;
-	super->flags = CRAMFS_FLAG_FSID_VERSION_2 | CRAMFS_FLAG_SORTED_DIRS;
+	super->magic = CRAMFS_MAGIC; /* #defined correctly on both endians */
+	super->flags = le32_to_cpu(CRAMFS_FLAG_FSID_VERSION_2 |
+				    CRAMFS_FLAG_SORTED_DIRS);
 	if (opt_holes)
-		super->flags |= CRAMFS_FLAG_HOLES;
+		super->flags |= le32_to_cpu(CRAMFS_FLAG_HOLES);
 	if (image_length > 0)
-		super->flags |= CRAMFS_FLAG_SHIFTED_ROOT_OFFSET;
-	super->size = size;
+		super->flags |= le32_to_cpu(CRAMFS_FLAG_SHIFTED_ROOT_OFFSET);
+	super->size = CRAM_SWAB_24(size);
 	memcpy(super->signature, CRAMFS_SIGNATURE, sizeof(super->signature));

-	super->fsid.crc = crc32(0L, Z_NULL, 0);
-	super->fsid.edition = opt_edition;
-	super->fsid.blocks = total_blocks;
-	super->fsid.files = total_nodes;
+	super->fsid.crc = le32_to_cpu(crc32(0L, Z_NULL, 0));
+	super->fsid.edition = le32_to_cpu(opt_edition);
+	super->fsid.blocks = le32_to_cpu(total_blocks);
+	super->fsid.files = le32_to_cpu(total_nodes);

 	memset(super->name, 0x00, sizeof(super->name));
 	if (opt_name)
@@ -337,11 +338,11 @@
 	else
 		strncpy(super->name, "Compressed", sizeof(super->name));

-	super->root.mode = root->mode;
-	super->root.uid = root->uid;
+	super->root.mode = le16_to_cpu(root->mode);
+	super->root.uid = le16_to_cpu(root->uid);
 	super->root.gid = root->gid;
-	super->root.size = root->size;
-	super->root.offset = offset >> 2;
+	super->root.size = CRAM_SWAB_24(root->size);
+	SET_CRAM_OFFSET(&(super->root), offset >> 2);

 	return offset;
 }
@@ -356,7 +357,7 @@
 		fprintf(stderr, "filesystem too big.  Exiting.\n");
 		exit(8);
 	}
-	inode->offset = (offset >> 2);
+	SET_CRAM_OFFSET(inode, offset >> 2);
 }


@@ -379,10 +380,10 @@

 			entry->dir_offset = offset;

-			inode->mode = entry->mode;
-			inode->uid = entry->uid;
+			inode->mode = le16_to_cpu(entry->mode);
+			inode->uid = le16_to_cpu(entry->uid);
 			inode->gid = entry->gid;
-			inode->size = entry->size;
+			inode->size = CRAM_SWAB_24(entry->size);
 			inode->offset = 0;
 			/* Non-empty directories, regfiles and symlinks will
 			   write over inode->offset later. */
@@ -395,7 +396,7 @@
 				*(base + offset + len) = '\0';
 				len++;
 			}
-			inode->namelen = len >> 2;
+			SET_CRAM_NAMELEN(inode, len >> 2);
 			offset += len;

 			/* TODO: this may get it wrong for chars >= 0x80.
@@ -503,7 +504,7 @@
 			exit(8);
 		}

-		*(u32 *) (base + offset) = curr;
+		*(u32 *) (base + offset) = le32_to_cpu(curr);
 		offset += 4;
 	} while (size);

@@ -652,6 +653,10 @@
 		exit(16);
 	}
 	fd = open(outfile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0) {
+		perror(outfile);
+		exit(8);
+	}

 	root_entry = calloc(1, sizeof(struct entry));
 	if (!root_entry) {
--- 2.4.10/include/linux/cramfs_fs.h	Thu Jul 19 16:14:53 2001
+++ current/include/linux/cramfs_fs.h	Fri Sep 28 18:33:42 2001
@@ -9,7 +9,12 @@

 #endif

+#if (defined(BYTE_ORDER) && BYTE_ORDER == BIG_ENDIAN) || defined(__MIPSEB__)
+#define CRAMFS_MAGIC		0x453dcd28	/* endian reversed magic */
+#else
 #define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
+#endif
+
 #define CRAMFS_SIGNATURE	"Compressed ROMFS"

 /*
@@ -80,6 +85,48 @@
  * changed to test super.future instead.
  */
 #define CRAMFS_SUPPORTED_FLAGS (0x7ff)
+
+/*
+ * Since cramfs (according to docs) should always be stored little endian,
+ * provide macros to swab the bitfields (mkcramfs uses this file too).
+ */
+#if (defined(BYTE_ORDER) && BYTE_ORDER == BIG_ENDIAN) || defined(__MIPSEB__)
+
+#ifndef le16_to_cpu
+#define le16_to_cpu(x)	( ( (0x0000FF00 & (x)) >> 8   ) | \
+			  ( (0x000000FF & (x)) << 8 ) )
+#endif /* le16_to_cpu */
+#ifndef le32_to_cpu
+#define le32_to_cpu(x)	( ( (0xFF000000 & (x)) >> 24 ) | \
+			  ( (0x00FF0000 & (x)) >> 8  ) | \
+			  ( (0x0000FF00 & (x)) << 8  ) | \
+			  ( (0x000000FF & (x)) << 24 ) )
+#endif /* le32_to_cpu */
+#define CRAM_SWAB_24(x)	( ( (0x00FF0000 & (x)) >> 16 ) | \
+			  ( (0x0000FF00 & (x))       ) | \
+			  ( (0x000000FF & (x)) << 16 ) )
+#define GET_CRAM_NAMELEN(x) (((u8*)(x))[8] & 63)
+#define GET_CRAM_OFFSET(x)  ((CRAM_SWAB_24(((u32*)(x))[2] & 0x00FFFFFF)<<2) | \
+			                 ((((u32*)(x))[2] & 0xC0000000)>>30) )
+#define SET_CRAM_OFFSET(x,y)   ( ((u32*)(x))[2] = (((y)&3)<<30) | \
+				 CRAM_SWAB_24( ( ((y) & 0x03FFFFFF) >> 2) ) | \
+				 (((u32)(((u8*)(x))[8] & 0x3F)) << 24) )
+#define SET_CRAM_NAMELEN(x,y)	( ((u8*)(x))[8] = ( ((0x3F & (y))) | \
+						    (0xC0 & ((u8*)(x))[8]) ) )
+
+#else
+#ifndef le16_to_cpu
+#define le16_to_cpu(x)		(x)
+#endif /* le16_to_cpu */
+#ifndef le32_to_cpu
+#define le32_to_cpu(x)		(x)
+#endif /* le32_to_cpu */
+#define CRAM_SWAB_24(x)		(x)
+#define GET_CRAM_NAMELEN(x)	((x)->namelen)
+#define GET_CRAM_OFFSET(x)	((x)->offset)
+#define SET_CRAM_OFFSET(x,y)	((x)->offset = y)
+#define SET_CRAM_NAMELEN(x,y)	((x)->namelen = y)
+#endif

 /* Uncompression interfaces to the underlying zlib */
 int cramfs_uncompress_block(void *dst, int dstlen, void *src, int srclen);
--- 2.4.10/fs/cramfs/inode.c	Mon Aug 27 07:53:49 2001
+++ current/fs/cramfs/inode.c	Fri Sep 28 18:36:06 2001
@@ -21,6 +21,7 @@
 #include <linux/cramfs_fs.h>

 #include <asm/uaccess.h>
+#include <asm/byteorder.h>

 #define CRAMFS_SB_MAGIC u.cramfs_sb.magic
 #define CRAMFS_SB_SIZE u.cramfs_sb.size
@@ -35,7 +36,7 @@

 /* These two macros may change in future, to provide better st_ino
    semantics. */
-#define CRAMINO(x)	((x)->offset?(x)->offset<<2:1)
+#define CRAMINO(x)	(GET_CRAM_OFFSET(x) ? GET_CRAM_OFFSET(x)<<2 : 1)
 #define OFFSET(x)	((x)->i_ino)

 static struct inode *get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode)
@@ -43,9 +44,9 @@
 	struct inode * inode = new_inode(sb);

 	if (inode) {
-		inode->i_mode = cramfs_inode->mode;
-		inode->i_uid = cramfs_inode->uid;
-		inode->i_size = cramfs_inode->size;
+		inode->i_mode = le16_to_cpu(cramfs_inode->mode);
+		inode->i_uid = le16_to_cpu(cramfs_inode->uid);
+		inode->i_size = CRAM_SWAB_24(cramfs_inode->size);
 		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
@@ -66,7 +67,8 @@
 			inode->i_data.a_ops = &cramfs_aops;
 		} else {
 			inode->i_size = 0;
-			init_special_inode(inode, inode->i_mode, cramfs_inode->size);
+			init_special_inode(inode, inode->i_mode,
+					   CRAM_SWAB_24(cramfs_inode->size));
 		}
 	}
 	return inode;
@@ -219,11 +221,11 @@
 	}

 	/* Check that the root inode is in a sane state */
-	if (!S_ISDIR(super.root.mode)) {
+	if (!S_ISDIR(le16_to_cpu(super.root.mode))) {
 		printk(KERN_ERR "cramfs: root is not a directory\n");
 		goto out;
 	}
-	root_offset = super.root.offset << 2;
+	root_offset = GET_CRAM_OFFSET(&(super.root)) << 2;
 	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
 		sb->CRAMFS_SB_SIZE=super.size;
 		sb->CRAMFS_SB_BLOCKS=super.fsid.blocks;
@@ -299,7 +301,7 @@
 		 * and the name padded out to 4-byte boundaries
 		 * with zeroes.
 		 */
-		namelen = de->namelen << 2;
+		namelen = GET_CRAM_NAMELEN(de) << 2;
 		nextoffset = offset + sizeof(*de) + namelen;
 		for (;;) {
 			if (!namelen)
@@ -308,7 +310,8 @@
 				break;
 			namelen--;
 		}
-		error = filldir(dirent, name, namelen, offset, CRAMINO(de), de->mode >> 12);
+		error = filldir(dirent, name, namelen, offset, CRAMINO(de),
+				le16_to_cpu(de->mode) >> 12);
 		if (error)
 			break;

@@ -339,7 +342,7 @@
 		if (sorted && (dentry->d_name.name[0] < name[0]))
 			break;

-		namelen = de->namelen << 2;
+		namelen = GET_CRAM_NAMELEN(de) << 2;
 		offset += sizeof(*de) + namelen;

 		/* Quick check that the name is roughly the right length */
@@ -385,9 +388,10 @@

 		start_offset = OFFSET(inode) + maxblock*4;
 		if (page->index)
-			start_offset = *(u32 *) cramfs_read(sb, blkptr_offset-4, 4);
-		compr_len = (*(u32 *) cramfs_read(sb, blkptr_offset, 4)
-			     - start_offset);
+			start_offset = le32_to_cpu(*(u32 *)
+				        cramfs_read(sb, blkptr_offset - 4, 4));
+		compr_len = le32_to_cpu(*(u32 *)
+			     cramfs_read(sb, blkptr_offset, 4)) - start_offset;
 		pgdata = kmap(page);
 		if (compr_len == 0)
 			; /* hole */
