Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 20:46:36 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:38054 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123927AbSJWSqf>; Wed, 23 Oct 2002 20:46:35 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA12991;
	Wed, 23 Oct 2002 20:46:58 +0200 (MET DST)
Date: Wed, 23 Oct 2002 20:46:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: KSeg0 coherency policy selection.
In-Reply-To: <AEC4671C8179D61194DE0002B328BDD2070C8D@ATLOPS>
Message-ID: <Pine.GSO.3.96.1021023204431.3179J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 23 Oct 2002, Dinesh Nagpure wrote:

> I tried following the instructions :
>    cvs -d :pserver:cvs@oss.sgi.com:/cvs login
>    (Only needed the first time you use anonymous CVS, the password is "cvs")
>    cvs -d :pserver:cvs@oss.sgi.com:/cvs co linux
> 
> where you insert linux, libc, gdb or faq for <repository>. 
> 
> That responded with :
> 	cvs server : can not find module 'linux' - ignored
> 	cvs [checkout aborted] can not expand modules.

 The tree was moved -- try ":pserver:cvs@ftp.linux-mips.org:/home/cvs",
instead.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
