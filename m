Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f95KwCI20245
	for linux-mips-outgoing; Fri, 5 Oct 2001 13:58:12 -0700
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f95Kw6D20236
	for <linux-mips@oss.sgi.com>; Fri, 5 Oct 2001 13:58:07 -0700
Received: (qmail 1804 invoked by uid 0); 5 Oct 2001 20:58:00 -0000
Received: from pd953ac6c.dip.t-dialin.net (HELO bogon.ms20.nix) (217.83.172.108)
  by mail.gmx.net (mp004-rz3) with SMTP; 5 Oct 2001 20:58:00 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id 8B906B815; Fri,  5 Oct 2001 22:59:21 +0200 (CEST)
Date: Fri, 5 Oct 2001 22:59:20 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: ralf@gnu.org
Cc: linux-mips@oss.sgi.com
Subject: dvhtool's calculates free space in vh incorrectly
Message-ID: <20011005225920.A13026@bogon.ms20.nix>
Mail-Followup-To: ralf@gnu.org, linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The way dvhtool calculates the free space in the vh is bogus. Since this
number is too small dvhtool may write past the end of the vh. Attached
patch fixes this. Can I get the dvhtool cvs commit messages from
somewhere?
 -- Guido


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dvhtool-2001-10-05.diff"

--- dvhtool-1.0.1.orig/dvhlib.c
+++ dvhtool-1.0.1/dvhlib.c
@@ -325,8 +327,10 @@
 	if (res == -1)
 		die("Couldn't stat source file");
 
-	/* XXX pad to blocksize? */
-	size = vh->vh_pt[8].pt_nblks * blksize - istat.st_size;
+	/* calculate free blocks in vh */
+	size = vh->vh_pt[8].pt_nblks				/* total vh size */
+		- ( vh->vh_pt[8].pt_firstlbn + 4 )		/* reserved area */
+		- (( istat.st_size + blksize - 1 ) / blksize );	/* pad to blocksize */
 	/*
 	 * Are we replacing an existing file, check for enough space and free
 	 * entry in volume header
@@ -336,16 +340,15 @@
 			/* It's an existing file, delete it.  */
 			memset(vd->vd_name, 0, VDNAMESIZE);
 			vd->vd_nbytes = 0;
-			break;
 		}
 		if ( vd->vd_nbytes ) {
-			size -= vd->vd_nbytes;
+			size -= (vd->vd_nbytes + blksize - 1 ) / blksize; /* pad to blocksize */
 			num++;
 		}
 		vd++;
 	}
 
-	if ( num == NVDIR ) 
+	if ( num == NVDIR )
 		die("No more free entries in volume header");
 	if ( size <= 0 )
 		die("Not enough space left in volume header");
@@ -403,7 +406,7 @@
 				die("Short write");
 			}
 		}
-		dest += (vd->vd_nbytes + 511) / 512;	/* XXX Blocksize  */
+		dest += (vd->vd_nbytes + blksize - 1) / blksize;
 		vd++;
 	}
 

--xgyAXRrhYN0wYx8y--
