Received:  by oss.sgi.com id <S553743AbQJ2Qt2>;
	Sun, 29 Oct 2000 08:49:28 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:47115 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553736AbQJ2QtL>;
	Sun, 29 Oct 2000 08:49:11 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A1AA58E7; Sun, 29 Oct 2000 17:49:08 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id F1158900C; Sun, 29 Oct 2000 17:47:32 +0100 (CET)
Date:   Sun, 29 Oct 2000 17:47:32 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: atomic.h changes fixed bug Was: CVS Update@oss.sgi.com: linux
Message-ID: <20001029174732.D2663@paradigm.rfc822.org>
References: <20001026235921Z553785-493+346@oss.sgi.com> <20001029172517.C2663@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001029172517.C2663@paradigm.rfc822.org>; from flo@rfc822.org on Sun, Oct 29, 2000 at 05:25:17PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Oct 29, 2000 at 05:25:17PM +0100, Florian Lohoff wrote:
> On Thu, Oct 26, 2000 at 04:59:17PM -0700, Ralf Baechle wrote:
> > CVSROOT:	/home/pub/cvs
> > Module name:	linux
> > Changes by:	ralf@oss.sgi.com	00/10/26 16:59:17
> > 
> > Modified files:
> > 	include/asm-mips: atomic.h 
> > 	include/asm-mips64: atomic.h 
> > 
> > Log message:
> > 	Add memory clobbers to the atomic_*_return functions.  I hope this
> > 	fixes the file corruption / `D' state processes people observe.
> 
> This at least fixes the file corruption stuff i have been seeing
> (Never The Same Checksum aka NTSC)

I was to quick ... It seems to be partially fixed ...

flo@remake:~$ md5sum xfree86_4.0.1.orig.tar.gz
e91fa9fbda045965f12a49def8cafb3a  xfree86_4.0.1.orig.tar.gz
flo@remake:~$ md5sum xfree86_4.0.1.orig.tar.gz
06f1bb64a75cf475dfbbde5bb28d8420  xfree86_4.0.1.orig.tar.gz
flo@remake:~$ md5sum xfree86_4.0.1.orig.tar.gz
ade38e19b446a6432f9424994840a699  xfree86_4.0.1.orig.tar.gz
flo@remake:~$ md5sum xfree86_4.0.1.orig.tar.gz
8495ab01d5bd2047311e38d0a7612882  xfree86_4.0.1.orig.tar.gz
flo@remake:~$ pwd
/home2/flo
flo@remake:~$ md5sum /home/flo/xfree86_4.0.1.orig.tar.gz
590767187e145407bcda582facf5afc0  /home/flo/xfree86_4.0.1.orig.tar.gz
flo@remake:~$ md5sum /home/flo/xfree86_4.0.1.orig.tar.gz
590767187e145407bcda582facf5afc0  /home/flo/xfree86_4.0.1.orig.tar.gz
flo@remake:~$ md5sum /home/flo/xfree86_4.0.1.orig.tar.gz
590767187e145407bcda582facf5afc0  /home/flo/xfree86_4.0.1.orig.tar.gz
flo@remake:~$ df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1               762860    634544     89564  88% /
/dev/sdb1              2079044     50668   1922764   3% /home2

So it seems there is still some problem in some i/o stuff concerning
the different disk ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
