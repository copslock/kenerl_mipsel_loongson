Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g01Kbir26420
	for linux-mips-outgoing; Tue, 1 Jan 2002 12:37:44 -0800
Received: from megaela.srvf.org (megaela.fe.dis.titech.ac.jp [131.112.171.110])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g01Kbfg26417
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 12:37:41 -0800
Received: (qmail 14262 invoked from network); 1 Jan 2002 19:37:38 -0000
Received: from unknown (HELO celesta.gotom.jp.fe.dis.titech.ac.jp) (127.0.0.1)
  by localhost with SMTP; 1 Jan 2002 19:37:38 -0000
Date: Wed, 02 Jan 2002 04:36:12 +0900
Message-ID: <wtw8zbhkgnn.wl@fe.dis.titech.ac.jp>
From: GOTO Masanori <gotom@debian.or.jp>
To: linux-mips@oss.sgi.com
Subject: sysirix.c returns wrong error ?
User-Agent: Wanderlust/2.9.2 (Unchained Melody) SEMI/1.14.3 (Ushinoya)
 FLIM/1.14.3 (=?ISO-8859-4?Q?Unebigory=F2mae?=) APEL/10.3 Emacs/20.7
 (i386-debian-linux-gnu) MULE/4.1 (AOI)
MIME-Version: 1.0 (generated by SEMI 1.14.3 - "Ushinoya")
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

The following patch is for kernel/sysirix.c kernel vanilla 2.4.17,
I think this routine returns wrong error... Is it ok?


--- arch/mips/kernel/sysirix.c.vanilla	Wed Jan  2 04:29:13 2002
+++ arch/mips/kernel/sysirix.c	Wed Jan  2 04:30:19 2002
@@ -1908,7 +1908,7 @@
 	}
 
 	if (put_user(0, eob) < 0) {
-		error = EFAULT;
+		error = -EFAULT;
 		goto out_putf;
 	}
 

-- gotom
