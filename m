Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g63GVcRw009960
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 09:31:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g63GVcZK009959
	for linux-mips-outgoing; Wed, 3 Jul 2002 09:31:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc53.attbi.com (rwcrmhc53.attbi.com [204.127.198.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g63GVORw009940
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 09:31:25 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020703163519.IVNN15755.rwcrmhc53.attbi.com@ocean.lucon.org>;
          Wed, 3 Jul 2002 16:35:19 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 9351D125D3; Wed,  3 Jul 2002 09:35:18 -0700 (PDT)
Date: Wed, 3 Jul 2002 09:35:18 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>,
   binutils@sources.redhat.com, gcc@gcc.gnu.org
Subject: RFC: Use -Wa,-xgot for Linux/mips (Re: MIPS GOT overflow in gcc 3.2.)
Message-ID: <20020703093518.A2401@lucon.org>
References: <20020701184640.A2043@lucon.org> <1025575632.30577.64.camel@ghostwheel.cygnus.com> <1025579401.1785.0.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1025579401.1785.0.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Jul 01, 2002 at 08:09:59PM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2002 at 08:09:59PM -0700, Eric Christopher wrote:
> 
> > AFAIK it happens to mozilla as well.
> > 
> > Guh.
> 
> There are a few different possible solutions, one is to do the
> -fPIC/-fpic split, another is to copy to SGI multigot, I'm sure there
> are other solutions as well...
> 

I am enclosing a kludge here. With that, I got

http://gcc.gnu.org/ml/gcc-testresults/2002-07/msg00062.html

Any comments?


H.J.

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="libjava-xgot.patch"

2002-07-02  H.J. Lu <hjl@gnu.org>

	* ltcf-c.sh (ac_cv_prog_cc_pic): Add "-Wa,-xgot" for
	Linux/mips.
	* ltcf-cxx.sh (ac_cv_prog_cc_pic): Likewise.
	* ltcf-gcj.sh (ac_cv_prog_cc_pic): Likewise.

--- gcc/ltcf-c.sh.xgot	Mon Sep 10 08:39:17 2001
+++ gcc/ltcf-c.sh	Tue Jul  2 00:06:54 2002
@@ -672,6 +672,14 @@ else
 	 ac_cv_prog_cc_pic=-Kconform_pic
       fi
       ;;
+    linux*) 
+      ac_cv_prog_cc_pic='-fPIC'
+      case "$host_cpu" in
+      mips*)  
+	ac_cv_prog_cc_pic="$ac_cv_prog_cc_pic -Wa,-xgot"
+	;;      
+      esac
+      ;;      
     *)
       ac_cv_prog_cc_pic='-fPIC'
       ;;
--- gcc/ltcf-cxx.sh.xgot	Mon Sep 10 08:39:17 2001
+++ gcc/ltcf-cxx.sh	Tue Jul  2 13:40:41 2002
@@ -707,6 +707,14 @@ if test "$with_gcc" = yes; then
       ac_cv_prog_cc_pic=-Kconform_pic
     fi
     ;;
+  linux*) 
+    ac_cv_prog_cc_pic='-fPIC'
+    case "$host_cpu" in
+    mips*)  
+      ac_cv_prog_cc_pic="$ac_cv_prog_cc_pic -Wa,-xgot"
+      ;;      
+    esac
+    ;;      
   *)
     ac_cv_prog_cc_pic='-fPIC'
     ;;
--- gcc/ltcf-gcj.sh.xgot	Mon Sep 10 08:39:17 2001
+++ gcc/ltcf-gcj.sh	Mon Jul  1 23:49:06 2002
@@ -639,6 +639,14 @@ fi
 	 ac_cv_prog_cc_pic=-Kconform_pic
       fi
       ;;
+    linux*) 
+      ac_cv_prog_cc_pic='-fPIC'
+      case "$host_cpu" in
+      mips*)  
+	ac_cv_prog_cc_pic="$ac_cv_prog_cc_pic -Wa,-xgot"
+	;;      
+      esac
+      ;;      
     *)
       ac_cv_prog_cc_pic='-fPIC'
       ;;

--MGYHOYXEY6WxJCY8--
