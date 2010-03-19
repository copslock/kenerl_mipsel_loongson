Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 13:47:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37322 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492292Ab0CSMrr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Mar 2010 13:47:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2JCljNO017239;
        Fri, 19 Mar 2010 13:47:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2JCliVY017237;
        Fri, 19 Mar 2010 13:47:44 +0100
Date:   Fri, 19 Mar 2010 13:47:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <ffainelli@freebox.fr>
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] MIPS: bcm63xx: call board_register_device from
 device_initcall()
Message-ID: <20100319124744.GP4554@linux-mips.org>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
 <1264872898-28149-7-git-send-email-mbizon@freebox.fr>
 <201003021438.47105.ffainelli@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201003021438.47105.ffainelli@freebox.fr>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 02, 2010 at 02:38:47PM +0100, Florian Fainelli wrote:

And applied this one.  Thanks,

  Ralf
