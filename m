Received:  by oss.sgi.com id <S42530AbQJFK5f>;
	Fri, 6 Oct 2000 03:57:35 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:57355 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S42529AbQJFK5K>;
	Fri, 6 Oct 2000 03:57:10 -0700
Received: (qmail 4730 invoked from network); 6 Oct 2000 10:57:04 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 6 Oct 2000 10:57:03 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: insmod hates RELA? 
In-reply-to: Your message of "Fri, 06 Oct 2000 12:26:28 +0200."
             <Pine.GSO.3.96.1001006121819.26752C-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 06 Oct 2000 21:57:02 +1100
Message-ID: <22488.970829822@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 6 Oct 2000 12:26:28 +0200 (MET DST), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> The linker tends to create empty .rela sections even if there is no input
>for them.  This actually is a minor error and until (unless) we modify the
>linker just use the quick fix for modutils that is available from my FTP
>site (not that these modutils actually work ;-) ). 

Against modutils 2.3.17.  Does 2.3.17+this patch work on mips?

Index: 18.2/obj/obj_load.c
--- 18.2/obj/obj_load.c Fri, 08 Sep 2000 16:46:27 +1100 kaos (modutils-2.3/21_obj_load.c 1.7 644)
+++ 18.2(w)/obj/obj_load.c Fri, 06 Oct 2000 21:45:44 +1100 kaos (modutils-2.3/21_obj_load.c 1.7 644)
@@ -151,11 +151,13 @@ obj_load (int fp, Elf32_Half e_type, con
 
 #if SHT_RELM == SHT_REL
 	case SHT_RELA:
-	  error("RELA relocations not supported on this architecture");
+	  if (sec->header.sh_size)
+	    error("RELA relocations not supported on this architecture");
 	  return NULL;
 #else
 	case SHT_REL:
-	  error("REL relocations not supported on this architecture");
+	  if (sec->header.sh_size)
+	    error("REL relocations not supported on this architecture");
 	  return NULL;
 #endif
 
