Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 15:31:17 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:21785 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133787AbWCBPbI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Mar 2006 15:31:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k22FXjRw010734;
	Thu, 2 Mar 2006 15:33:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k22FXils010733;
	Thu, 2 Mar 2006 15:33:44 GMT
Date:	Thu, 2 Mar 2006 15:33:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	gregkh@suse.de, tbm@cyrius.com
Subject: Re: [PATCH] Buglet in Alchemy OHCI driver
Message-ID: <20060302153344.GA8487@linux-mips.org>
References: <20060301183026.GL31957@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301183026.GL31957@cosmic.amd.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 01, 2006 at 11:30:26AM -0700, Jordan Crouse wrote:
> Date:	Wed, 1 Mar 2006 11:30:26 -0700
> From:	"Jordan Crouse" <jordan.crouse@amd.com>
> To:	linux-usb-devel@lists.sourceforge.net
> cc:	linux-mips@linux-mips.org, gregkh@suse.de, tbm@cyrius.com
> Subject: [PATCH] Buglet in Alchemy OHCI driver
> Content-Type: multipart/mixed;
>  boundary=5vNYLRcllDrimb99
> 
> Martin Michlmayr spotted this potentially serious bug.  Please apply.

Ehh...  This problem doesn't exist on kernel.org.  Greg, can you ignore
this one, please?

  Ralf
