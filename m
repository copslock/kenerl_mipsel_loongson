Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 12:41:40 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@sirjeppe-pt.tunnel.tserv1.fmt.ipv6.he.net)) by linux-mips.org
	id <S8225475AbTI3Lli>; Tue, 30 Sep 2003 12:41:38 +0100
Date: Tue, 30 Sep 2003 12:41:38 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: [Indy] text console
Message-ID: <20030930124138.B5928@linux-mips.org>
References: <20030926122012.GC19876@icm.edu.pl> <20030930112541.GE26507@icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030930112541.GE26507@icm.edu.pl>; from rathann@icm.edu.pl on Tue, Sep 30, 2003 at 01:25:42PM +0200
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 30, 2003 at 01:25:42PM +0200, Dominik 'Rathann' Mierzejewski wrote:
> On Fri, Sep 26, 2003 at 02:20:12PM +0200, Dominik 'Rathann' Mierzejewski wrote:
> > Hi.
> > 
> > Is there any way to change the size and refresh rate for the
> > text console? I've searched in the mail-list archives and on
> > google and came up with nothing.
> 
> Doesn't anyone know? Please help or say it's impossible. I'm
> stuck with 1280x1024@60Hz which is very uncomfortable to my
> eyes.

newport_con nor newport xfree86 driver doesn't perform any VC2
programing. that means that there is currently no way to setup
refresh rate from linux.

	ladis
