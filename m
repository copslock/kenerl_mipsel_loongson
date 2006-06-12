Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2006 04:19:37 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:11904 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S8126480AbWFLDT1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Jun 2006 04:19:27 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.60 #1 (Red Hat Linux))
	id 1FpcxR-0004tn-KK; Mon, 12 Jun 2006 03:19:18 +0000
Message-ID: <448CDD34.50502@pobox.com>
Date:	Sun, 11 Jun 2006 23:19:16 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Herbert Valerio Riedel <hvr@gnu.org>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ppopov@embeddedalley.com, sshtylyov@ru.mvista.com,
	ralf@linux-mips.org
Subject: Re: [PATCH netdev-2.6#upstream] net: au1000_eth: PHY framework conversion
References: <E1Fli0i-0006o2-Tb@fencepost.gnu.org>
In-Reply-To: <E1Fli0i-0006o2-Tb@fencepost.gnu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Herbert Valerio Riedel wrote:
> convert au1000_eth driver to use PHY framework and garbage collected
> functions and identifiers that became unused/obsolete in the process
> 
> Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>

applied
