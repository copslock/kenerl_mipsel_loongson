Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 11:45:19 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:14156 "EHLO
	t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S1123891AbSJQJpT>; Thu, 17 Oct 2002 11:45:19 +0200
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id MAA04049;
	Thu, 17 Oct 2002 12:43:51 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA31589; Thu, 17 Oct 2002 13:04:06 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by niisi.msk.ru (8.12.5/8.12.5) with ESMTP id g9H9fnpa003692;
	Thu, 17 Oct 2002 13:41:50 +0400 (MSK)
Message-ID: <3DAE872E.D5EF0E4D@niisi.msk.ru>
Date: Thu, 17 Oct 2002 13:47:26 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Johannes Stezenbach <js@convergence.de>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
References: <20021015172108.GD21220@convergence.de> <Pine.GSO.3.96.1021016140828.14774I-100000@delta.ds2.pg.gda.pl> <20021016125233.GA25227@convergence.de> <20021016163038.GA26585@convergence.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Johannes Stezenbach wrote:
> 
> I wrote:
> 
> > sysmips is history with current glibc since the Linux kernel emulates
> > LL/SC for CPUs that don't have it. This emulation is actually faster than
> > sysmips. (You'd think it's slower because it's one syscall vs. two
> > emulated instructions. But with LL/SC glibc can use test-and-set
>                                                       ^^^^^^^^^^^^
> > which enables a more efficient linux-threads mutex implementation.)
> 
> Oops, I meant compare-and-swap.

Implement new sysmips then.

Regards,
Gleb.
