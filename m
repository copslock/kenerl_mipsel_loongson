Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 18:04:47 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40090 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1492628AbZKXREn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 18:04:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAOH4wfX019347;
	Tue, 24 Nov 2009 17:04:59 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAOH4wfd019345;
	Tue, 24 Nov 2009 17:04:58 GMT
Date:	Tue, 24 Nov 2009 17:04:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: add au1210 to cpu type detector.
Message-ID: <20091124170457.GA11531@linux-mips.org>
References: <1259080269-3631-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259080269-3631-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 05:31:09PM +0100, Manuel Lauss wrote:

> Au1210 is an au1200 with slightly crippled media engine and a
> different PRId.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Ralf please fold this one into "MIPS: Alchemy: Simple cpu subtype detector"
> if its not too much trouble. Thanks!

Folding is not much trouble as long as it doesn't cause conflicts with
patches higher in the patch stack.

Done & thanks,

  Ralf
