Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 11:53:58 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:2589 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465659AbVJEKxm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 11:53:42 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j95Arar3009777;
	Wed, 5 Oct 2005 11:53:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j95Ara7Z009776;
	Wed, 5 Oct 2005 11:53:36 +0100
Date:	Wed, 5 Oct 2005 11:53:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix warning in tlbex.c for CONFIG_32BIT
Message-ID: <20051005105336.GH2699@linux-mips.org>
References: <4343586E.4030703@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343586E.4030703@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 04, 2005 at 09:37:02PM -0700, David Daney wrote:
> Date:	Tue, 04 Oct 2005 21:37:02 -0700
> From:	David Daney <ddaney@avtrex.com>
> To:	linux-mips@linux-mips.org
> Subject: [PATCH] fix warning in tlbex.c for CONFIG_32BIT
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
                                                ^^^^^^^^^^^^^

Applied - BUT: your mailer garbles patches ...

  Ralf
