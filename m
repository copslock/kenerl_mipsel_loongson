Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 15:48:23 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41493 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903568Ab1KIOsQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 15:48:16 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9EmEJZ019311;
        Wed, 9 Nov 2011 14:48:14 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9EmCX7019304;
        Wed, 9 Nov 2011 14:48:12 GMT
Date:   Wed, 9 Nov 2011 14:48:12 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, netdev@vger.kernel.org,
        linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH RESEND 01/18] MIPS: Alchemy: remove PB1000 support
Message-ID: <20111109144812.GA19187@linux-mips.org>
References: <1320174224-27305-2-git-send-email-manuel.lauss@googlemail.com>
 <1320234824-28604-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320234824-28604-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7760

On Wed, Nov 02, 2011 at 12:53:44PM +0100, Manuel Lauss wrote:

> Noone seems to have test hardware or care anymore.  Drop PB1000 support
> and along with it the old Alchemy PCMCIA socket driver.

Nobody (n)acked so I queued this one for 3.3.

Thanks,

  Ralf
