Received:  by oss.sgi.com id <S553906AbRBXOMR>;
	Sat, 24 Feb 2001 06:12:17 -0800
Received: from cabal.wiggy.net ([195.64.66.141]:11524 "EHLO fog.mors.wiggy.net")
	by oss.sgi.com with ESMTP id <S553838AbRBXOLx>;
	Sat, 24 Feb 2001 06:11:53 -0800
Received: (from wichert@localhost)
	by fog.mors.wiggy.net (8.11.2/8.11.2/Debian 8.11.2-1) id f1OCfLu04948;
	Sat, 24 Feb 2001 13:41:21 +0100
Date:   Sat, 24 Feb 2001 13:41:21 +0100
From:   Wichert Akkerman <wichert@cistron.nl>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        linux-mips <linux-mips@fnet.fr>
Subject: Re: strace package
Message-ID: <20010224134121.A4925@cistron.nl>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>,
	"'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
	linux-mips <linux-mips@fnet.fr>
References: <20010116134453.B12858@bacchus.dhis.org> <Pine.GSO.3.96.1010116171558.5546M-100000@delta.ds2.pg.gda.pl> <20010219133346.A17354@cistron.nl> <20010220213703.B2086@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010220213703.B2086@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Feb 20, 2001 at 09:37:03PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Previously Ralf Baechle wrote:
> Conincidentally I today built strace-cvs for MIPS before receiving your
> message and found it to be working just fine.

Good!

> The only bug which my last several month old build from an older
> snapshot doesn't have is that syscall 4129 (from memory, number may be
> incorrect) gets decoded as a syscall with very many arguments (~ 20).

Hmm, 4129 is delete_module, which is handled exactly like sys_chdir
(syscal with one string argument). Looking at the syscall table I
can't find any syscall with that many argument, the highest number
I can find is 6 (mmap, recvfrom and sendto).

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
