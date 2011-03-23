Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:31:56 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4327 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491931Ab1CWVbx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:31:53 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d8a66fe0000>; Wed, 23 Mar 2011 14:32:46 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 23 Mar 2011 14:31:50 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 23 Mar 2011 14:31:50 -0700
Message-ID: <4D8A66C5.4010503@caviumnetworks.com>
Date:   Wed, 23 Mar 2011 14:31:49 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 05/38] mips: cavium-octeon: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de> <20110323210535.042979916@linutronix.de>
In-Reply-To: <20110323210535.042979916@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2011 21:31:50.0146 (UTC) FILETIME=[B8502E20:01CBE9A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/23/2011 02:08 PM, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   arch/mips/cavium-octeon/octeon-irq.c |  237 ++++++++++++++++-------------------
>   arch/mips/pci/msi-octeon.c           |   20 +-
>   2 files changed, 120 insertions(+), 137 deletions(-)
>
[...]

Argh!

This definitely collides with my Octeon IRQ rewrite, which does the same 
thing and more.  My patch is pending my cpu_{on,off}line chip function 
patch for the IRQ core.

David Daney
