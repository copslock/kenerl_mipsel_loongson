Received:  by oss.sgi.com id <S553859AbQJOAPk>;
	Sat, 14 Oct 2000 17:15:40 -0700
Received: from gandalf1.physik.uni-konstanz.de ([134.34.144.69]:59405 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553855AbQJOAPZ>; Sat, 14 Oct 2000 17:15:25 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 13kbSV-0002wm-00; Sun, 15 Oct 2000 02:15:23 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13kbSV-0000pi-00; Sun, 15 Oct 2000 02:15:23 +0200
Date:   Sun, 15 Oct 2000 02:15:23 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux-mips@oss.sgi.com
Subject: patches for dvhtool
Message-ID: <20001015021522.B3106@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
User-Agent: Mutt/1.0.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii

Hi,
with the following two patches (first against dvhtool, second against
current cvs kernel) it's possible to boot the Indy from a local harddisk
without the need of IRIX to install it in the volume header. Set 
setenv OSLoader linux 
and 
setenv OSLoadPartition /dev/sd(whatever)
in the boot-prom and do a: 
dvhtool -d /dev/sda(whatever) --unix-to-vh (your_favorite_ecoff_kernel) linux
Regards,
 -- Guido

P.S.: ...and no, I don't know if it will work, so better backup
your volumheader first.

-- 
GPG-Public Key: finger agx@debian.org

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dvhtool.diff"

? dvhtool.diff
Index: Makefile
===================================================================
RCS file: /cvs/dvhtool/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- Makefile	2000/07/07 22:06:38	1.2
+++ Makefile	2000/10/14 23:32:17
@@ -2,8 +2,8 @@
 # Makefile for dvhtool
 #
 CC = gcc
-CFLAGS = -O2 -Wall -D_XOPEN_SOURCE=500L -DDEBUG
-LDFLAGS = -s
+CFLAGS = -O2 -Wall -D_XOPEN_SOURCE=500L -D__MIPSEB__
+LDFLAGS = -s -static
 
 OBJS = dvhtool.o dvhlib.o
 
Index: dvh.h
===================================================================
RCS file: /cvs/dvhtool/dvh.h,v
retrieving revision 1.1
diff -u -r1.1 dvh.h
--- dvh.h	2000/07/07 02:24:53	1.1
+++ dvh.h	2000/10/14 23:32:17
@@ -126,6 +126,8 @@
 #define	PTYPE_XFS	10		/* partition is sgi XFS */
 #define	PTYPE_XFSLOG	11		/* partition is sgi XFS log */
 #define	PTYPE_XLV	12		/* partition is part of an XLV vol*/
+#define PTYPE_LINUXSWAP	0x82		/* partition is linux swap */
+#define PTYPE_LINUX	0x83		/* partition is linux native */
 #define NPTYPES		16
 
 #define	VHMAGIC		0xbe5a941	/* randomly chosen value */
Index: dvhlib.c
===================================================================
RCS file: /cvs/dvhtool/dvhlib.c,v
retrieving revision 1.3
diff -u -r1.3 dvhlib.c
--- dvhlib.c	2000/07/11 23:50:44	1.3
+++ dvhlib.c	2000/10/14 23:32:18
@@ -40,6 +40,8 @@
 	case PTYPE_XFS:		return "XFS";
 	case PTYPE_XFSLOG:	return "XFS Log";
 	case PTYPE_XLV:		return "XLV Volume";
+	case PTYPE_LINUXSWAP:	return "Linux swap";
+	case PTYPE_LINUX:	return "Linux native";
 	default:		return "Unknown Partition Type";
 	}
 
@@ -128,6 +130,20 @@
 }
 
 static void
+recalc_vh_csum( struct dvh_handle *dvh)
+{
+	uint32_t csum = 0;
+	int i;
+
+	dvh->dvh_vh.vh_csum = 0;
+	i = sizeof(struct volume_header) / sizeof(uint32_t) - 1;
+	while(i--) {
+		csum += ntohl(dvh->dvh_cs[i]);
+	}
+	dvh->dvh_vh.vh_csum = -csum;
+}
+
+static void
 dvh_swap_device_parameters(struct device_parameters *dp)
 {
 	swap_short(dp->dp_cyls);
@@ -276,6 +292,7 @@
 	free(buf);
 }
 
+#if 0
 static int
 dvh_sort(const void *p1, const void *p2)
 {
@@ -294,6 +311,7 @@
 
 	return 0;
 }
+#endif
 
 void
 dvh_file_to_vh(struct dvh_handle *dvh, const char *u_name, const char *vh_name)
@@ -301,8 +319,9 @@
 	struct volume_header *vh = &dvh->dvh_vh;
 	struct volume_directory *vd = vh->vh_vd;
 	struct stat istat;
-	int i, res, ifd, dest;
-	char *buf;
+	long size=vh->vh_pt[8].pt_nblks * blksize;
+	int i, res, ifd, dest, num=0, newAdded=0;
+	char *buf[NVDIR];
 
 	ifd = open(u_name, O_RDONLY);
 	if (ifd == -1)
@@ -311,53 +330,102 @@
 	res = fstat(ifd, &istat);
 	if (res == -1)
 		die("Couldn't stat source file");
-
-	/* XXX Check for free entry before modifying the the dvh.  */
-	/* XXX Check for sufficient space before modifying the the dvh.  */
 
-	/* Are we replacing an existing file?  */
+	size=vh->vh_pt[8].pt_nblks * blksize - istat.st_size; /* XXX pad to blocksize? */
+	/* Are we replacing an existing file, check for enough space and free entry in volume header */
 	for (i = 0; i < NVDIR; i++) {
 		if (strncmp(vh_name, vd->vd_name, VDNAMESIZE) == 0) {
 			/* It's an existing file, delete it.  */
 			vd->vd_name[0] = '\0';
+			vd->vd_nbytes = 0;
 			break;
 		}
+		if ( vd->vd_nbytes ) {
+			size -= vd->vd_nbytes;
+			num++;
+		}
 		vd++;
 	}
 
-	/* First sort all dvh entries by their starting block.  */
-	qsort(vh->vh_vd, NVDIR, sizeof(struct volume_directory), dvh_sort);
+	if ( num == NVDIR ) 
+		die("No more free entries in Volume header");
+	if ( size <= 0 )
+		die("Not enough space left in volume header");
+	
+	/* copy all the other entries into a buffer */
+	vd = vh->vh_vd;
+	for (i = 0; i < NVDIR; i++) {
+		if( vd->vd_nbytes ) {
+			buf[i] = malloc(vd->vd_nbytes);
+			if (buf[i] == NULL)
+				die("No memory");
+			res = pread(dvh->dvh_fd, buf[i], vd->vd_nbytes, vd->vd_lbn * blksize);
+#ifdef DEBUG
+			fprintf(stderr,"Copying entry %s to tmp buffer\n", vd->vd_name);
+#endif
+			if (res != vd->vd_nbytes) {
+				die("Short read");
+			}
+		} else {
+			buf[i] = 0;
+		}
+		vd++;
+	}
 
-	/* Now move all files stuff all files to the beginning of the
-	   volume directory partition.  */
+	/* look for a free entry and add the new one */
+	vd = vh->vh_vd;
 	/* XXX The number 4 is observed from the IRIX dvh.  */
 	dest = vh->vh_pt[8].pt_firstlbn + 4;
-	vd = vh->vh_vd;
-	for (i = 0; i < NVDIR; i++, vd++) {
-		if (dest != vd->vd_lbn) {
-			/* Move it */
+	for (i = 0; i < NVDIR; i++) {
+		/* add new entry if we find a free entry and we've not already done it */
+		if( ! vd->vd_nbytes && ! newAdded ) { 
+#ifdef DEBUG
+			fprintf(stderr,"Adding new entry at position %d\n", i);
+#endif
+			vd->vd_nbytes = istat.st_size; 
+			strcpy( vd->vd_name, vh_name);
+			newAdded = 1;
+
+			buf[i] = malloc(vd->vd_nbytes);
+			if (buf[i] == NULL)
+				die("No memory");
+
+			res = pread(ifd, buf[i], vd->vd_nbytes, 0);
+			if (res != vd->vd_nbytes) {
+				die("Short read");
+			}
+			close(ifd);
 		}
-
+		if ( vd->vd_nbytes ) { /* write buf to Volume Directory */
+#ifdef DEBUG
+			fprintf(stderr,"Writing buf[%d]\n", i);
+#endif
+			vd->vd_lbn = dest;
+			res = pwrite(dvh->dvh_fd, buf[i], vd->vd_nbytes, vd->vd_lbn * blksize);
+			if (res != vd->vd_nbytes) {
+				fprintf(stderr, "Wrote %d not %d\n", res, vd->vd_nbytes);
+				die("Short write");
+			}
+		}
 		dest += (vd->vd_nbytes + 511) / 512;	/* XXX Blocksize  */
 		vd++;
 	}
-	/* -> dest now points to the starting block for the new file.  */
-
-	/* XXX Now allocate a new directory entry for the file, populate it,
-	   write it to the vh and write the updated vh back to the disk.  */
 
-	buf = malloc(vd->vd_nbytes);
-	if (buf == NULL)
-		die("No memory");
-
-	res = pread(ifd, buf, vd->vd_nbytes, 0);
-	if (res != vd->vd_nbytes) {
-		die("Short read");
-	}
-
-	res = pwrite(dvh->dvh_fd, buf, vd->vd_nbytes, vd->vd_lbn * blksize);
-	if (res != vd->vd_nbytes)
-		die("Short write");
-
-	free(buf);
+	for ( i = 0; i < NVDIR; i++) {
+		if( buf[i] )
+			free( buf[i] );
+	}
+
+	/* write the new volume header too! */
+	recalc_vh_csum(dvh);
+#ifdef DEBUG
+	printf("About to rewrite the volume header: ");
+#endif
+	res = pwrite(dvh->dvh_fd, vh, sizeof(struct volume_header), 0);
+	if ( res != sizeof(struct volume_header )) {
+		die("Short write of volume header - bye bye\n");
+	}
+#ifdef DEBUG
+	printf("wrote %d bytes\n", res);
+#endif
 }
Index: dvhlib.h
===================================================================
RCS file: /cvs/dvhtool/dvhlib.h,v
retrieving revision 1.1
diff -u -r1.1 dvhlib.h
--- dvhlib.h	2000/07/07 02:24:53	1.1
+++ dvhlib.h	2000/10/14 23:32:18
@@ -22,6 +22,8 @@
 void extern dvh_close(struct dvh_handle *dvh);
 extern void dvh_vh_to_file(const struct dvh_handle *dvh, const char *vh_name,
                            const char *u_name);
+extern void dvh_file_to_vh(struct dvh_handle *dvh, const char *u_name,
+                           const char *dvh_name);
 extern void dvh_print_vh(const struct dvh_handle *vh);
 extern void dvh_print_vd(const struct dvh_handle *vh);
 extern void dvh_print_pt(const struct dvh_handle *vh);
Index: dvhtool.c
===================================================================
RCS file: /cvs/dvhtool/dvhtool.c,v
retrieving revision 1.2
diff -u -r1.2 dvhtool.c
--- dvhtool.c	2000/07/07 22:06:38	1.2
+++ dvhtool.c	2000/10/14 23:32:18
@@ -12,7 +12,7 @@
 #include "dvhlib.h"
 
 #if defined(__linux__) && defined(__MIPSEB__) && !defined (DEBUG)
-#define DEVICE "/dev/rdsk/dks0d1vol"
+#define DEVICE "/dev/sda"
 #else
 #define DEVICE "volhdr-1.dat"
 #endif
@@ -33,7 +33,8 @@
 #define OPT_PRINT_PT 258
 #define OPT_PRINT_ALL 259
 #define OPT_VH_TO_UNIX 260
-#define OPT_HELP 261
+#define OPT_UNIX_TO_VH 261
+#define OPT_HELP 262
 
 static struct option long_options[] = {
 	{"device", required_argument, NULL, OPT_DEVICE},
@@ -42,6 +43,7 @@
 	{"print-partitions", no_argument, NULL, OPT_PRINT_PT},
 	{"print-all", no_argument, NULL, OPT_PRINT_ALL},
 	{"vh-to-unix", no_argument, NULL, OPT_VH_TO_UNIX},
+	{"unix-to-vh", no_argument, NULL, OPT_UNIX_TO_VH},
 	{"help", no_argument, NULL, OPT_HELP},
 	{NULL, 0, NULL, 0}
 };
@@ -53,6 +55,7 @@
 	print_pt,
 	print_all,
 	vh_to_unix,
+	unix_to_vh,
 	show_usage
 };
 
@@ -98,6 +101,10 @@
 			action = vh_to_unix;
 			break;
 
+		case OPT_UNIX_TO_VH:
+			action = unix_to_vh;
+			break;
+
 		case OPT_HELP:
 		default:
 			action = show_usage;
@@ -146,6 +153,24 @@
 		u_file = argv[optind];
 		dvh_vh_to_file(dvh, vh_file, u_file);
 	}
+	if (action == unix_to_vh) {
+		char *vh_file, *u_file;
+
+		if (optind + 2 > argc)
+			die("Missing arguments");
+
+		u_file = argv[optind++];
+		vh_file = argv[optind];
+
+		/* close the dvh and reopen rw */
+		dvh_close(dvh);
+		dvh = dvh_open(device, DVH_READWRITE);
+		if (dvh == NULL)
+			die("Can't reopen Disk Volume Header rw");
+		
+		dvh_file_to_vh(dvh, u_file, vh_file);
+	}
+
 
 	dvh_close(dvh);
 

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmdline.diff"

--- arch/mips/arc/cmdline.c.orig	Sun Oct 15 01:48:40 2000
+++ arch/mips/arc/cmdline.c	Sun Oct 15 01:49:28 2000
@@ -27,13 +27,14 @@
 	"SystemPartition=",
 	"OSLoader=",
 	"OSLoadPartition=",
-	"OSLoadFilename="
+	"OSLoadFilename=",
+	"OSLoadOptions="
 };
 #define NENTS(foo) ((sizeof((foo)) / (sizeof((foo[0])))))
 
 void __init prom_init_cmdline(void)
 {
-	char *cp;
+	char *cp, *s;
 	int actr, i;
 
 	actr = 1; /* Always ignore argv[0] */
@@ -57,7 +58,21 @@
 	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
 		--cp;
 	*cp = '\0';
-
+	/* Indy'ism: check for root=partition, if not set it using OSLoadPartition */
+	if ( ! strstr( &(arcs_cmdline[0]), "root=")) {
+		for( i = 0; i < prom_argc; i++ ) {
+			if ( strstr( prom_argv[i], "OSLoadPartition")) {
+					s = strstr(prom_argv[i], "=");
+					strcpy(cp, "root");
+					cp += strlen("root");
+					strcpy(cp, s);
+					cp += strlen(s);
+					*cp = '\0';
+					break;
+				} 
+		}
+	}
+	
 #ifdef DEBUG_CMDLINE
 	prom_printf("prom_init_cmdline: %s\n", &(arcs_cmdline[0]));
 #endif

--PEIAKu/WMn1b1Hv9--
