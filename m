Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 01:40:13 +0100 (BST)
Received: from pengo.systems.pipex.net ([IPv6:::ffff:62.241.160.193]:4537 "HELO
	pengo.systems.pipex.net") by linux-mips.org with SMTP
	id <S8225202AbUHKAkJ>; Wed, 11 Aug 2004 01:40:09 +0100
Received: from nowt.org (81-178-207-113.dsl.pipex.com [81.178.207.113])
	by pengo.systems.pipex.net (Postfix) with ESMTP id 91FD34C0011D;
	Wed, 11 Aug 2004 01:40:04 +0100 (BST)
Received: from wren.home (wren.home [192.168.1.7])
	by nowt.org (Postfix) with ESMTP id 39B23AC92;
	Wed, 11 Aug 2004 01:40:04 +0100 (BST)
From: Paul Brook <paul@codesourcery.com>
Organization: CodeSourcery
To: gcc-patches@gcc.gnu.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Date: Wed, 11 Aug 2004 01:40:03 +0100
User-Agent: KMail/1.6.2
Cc: Richard Henderson <rth@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
References: <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl> <87zn5336h7.fsf@redhat.com> <20040810232020.GA21922@redhat.com>
In-Reply-To: <20040810232020.GA21922@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408110140.03725.paul@codesourcery.com>
Return-Path: <paul@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Wednesday 11 August 2004 00:20, Richard Henderson wrote:
> On Tue, Aug 10, 2004 at 06:30:28AM +0100, Richard Sandiford wrote:
> > The whole thing's in a sequence that gets discarded if
> > expand_doubleword_shift returns false.  Isn't that enough?
>
> Missed that, sorry.
>
> Patch seems ok then.  We'd have to add a new macro/target flag
> to handle non-truncating shifts -- we've got cases:
>
>   (1) Large shift shifts out all bits (ARM)

ARM is actually shift count modulo 256

Paul
