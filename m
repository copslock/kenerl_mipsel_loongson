Received:  by oss.sgi.com id <S42361AbQICQoO>;
	Sun, 3 Sep 2000 09:44:14 -0700
Received: from u-43.karlsruhe.ipdial.viaginterkom.de ([62.180.19.43]:8708 "EHLO
        u-43.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S42277AbQICQny>; Sun, 3 Sep 2000 09:43:54 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868896AbQIBMEv>;
        Sat, 2 Sep 2000 14:04:51 +0200
Date:   Sat, 2 Sep 2000 14:04:51 +0200
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Keith Owens <kaos@ocs.com.au>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: 2.4.0 do_fork() change, all architectures
Message-ID: <20000902140451.B560@bacchus.dhis.org>
References: <8124.967858043@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <8124.967858043@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Sep 02, 2000 at 12:27:23PM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Sep 02, 2000 at 12:27:23PM +1100, Keith Owens wrote:

> This patch hits every arch so it is being cross mailed to every arch
> mailing list, apologies for duplicates.  Please trim replies to the
> relevant mailing list.  Also please cc: kaos@ocs.com.au on replies, I
> am not on every list.
> 
> IA64 needs an extra parameter on do_fork() and copy_thread(), those
> functions are globally defined but arch local so there are changes to
> every architecture.  For everything except IA64, the extra parameter is
> unused and is specified as 0.  Sparc assembler changes by DaveM, blame
> me for everything else.  If nobody complains, this patch against
> 2.4.0-test8-pre1 will go to Linus on Monday evening GMT.

MIPS bits are ok.

  Ralf
