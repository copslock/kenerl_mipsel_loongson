Received:  by oss.sgi.com id <S553837AbQJ3BSa>;
	Sun, 29 Oct 2000 17:18:30 -0800
Received: from u-4.karlsruhe.ipdial.viaginterkom.de ([62.180.19.4]:18698 "EHLO
        u-4.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553828AbQJ3BSU>; Sun, 29 Oct 2000 17:18:20 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869074AbQJ3BRl>;
        Mon, 30 Oct 2000 02:17:41 +0100
Date:   Mon, 30 Oct 2000 02:17:41 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: atomic.h changes fixed bug Was: CVS Update@oss.sgi.com: linux
Message-ID: <20001030021741.B20700@bacchus.dhis.org>
References: <20001026235921Z553785-493+346@oss.sgi.com> <20001029172517.C2663@paradigm.rfc822.org> <20001029174732.D2663@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001029174732.D2663@paradigm.rfc822.org>; from flo@rfc822.org on Sun, Oct 29, 2000 at 05:47:32PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Oct 29, 2000 at 05:47:32PM +0100, Florian Lohoff wrote:

> > This at least fixes the file corruption stuff i have been seeing
> > (Never The Same Checksum aka NTSC)
> 
> I was to quick ... It seems to be partially fixed ...
> 
> flo@remake:~$ md5sum xfree86_4.0.1.orig.tar.gz
> e91fa9fbda045965f12a49def8cafb3a  xfree86_4.0.1.orig.tar.gz
> flo@remake:~$ md5sum xfree86_4.0.1.orig.tar.gz
> 06f1bb64a75cf475dfbbde5bb28d8420  xfree86_4.0.1.orig.tar.gz
> flo@remake:~$ md5sum xfree86_4.0.1.orig.tar.gz
> ade38e19b446a6432f9424994840a699  xfree86_4.0.1.orig.tar.gz
> flo@remake:~$ md5sum xfree86_4.0.1.orig.tar.gz
> 8495ab01d5bd2047311e38d0a7612882  xfree86_4.0.1.orig.tar.gz
> flo@remake:~$ pwd
> /home2/flo
> flo@remake:~$ md5sum /home/flo/xfree86_4.0.1.orig.tar.gz
> 590767187e145407bcda582facf5afc0  /home/flo/xfree86_4.0.1.orig.tar.gz
> flo@remake:~$ md5sum /home/flo/xfree86_4.0.1.orig.tar.gz
> 590767187e145407bcda582facf5afc0  /home/flo/xfree86_4.0.1.orig.tar.gz
> flo@remake:~$ md5sum /home/flo/xfree86_4.0.1.orig.tar.gz
> 590767187e145407bcda582facf5afc0  /home/flo/xfree86_4.0.1.orig.tar.gz
> flo@remake:~$ df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/sda1               762860    634544     89564  88% /
> /dev/sdb1              2079044     50668   1922764   3% /home2
> 
> So it seems there is still some problem in some i/o stuff concerning
> the different disk ...

I only get those corruption reports from Indy users but from no other
platform.

  Ralf
