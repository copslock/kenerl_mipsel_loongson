Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 23:54:52 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7816 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2100592Ab1C1Vyt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2011 23:54:49 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d9103de0000>; Mon, 28 Mar 2011 14:55:42 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 28 Mar 2011 14:54:45 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 28 Mar 2011 14:54:45 -0700
Message-ID: <4D9103A5.2080200@caviumnetworks.com>
Date:   Mon, 28 Mar 2011 14:54:45 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch 3/3] MIPS: Octeon: Simplify irq_cpu_on/offline irq chip
 functions
References: <20110328150330.110780523@linutronix.de> <20110328150627.777498250@linutronix.de>
In-Reply-To: <20110328150627.777498250@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2011 21:54:45.0660 (UTC) FILETIME=[C03FB5C0:01CBED92]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/28/2011 08:06 AM, Thomas Gleixner wrote:
> Make use of the IRQCHIP_ONOFFLINE_ENABLED flag and remove the
> wrappers. Use irqd_irq_disabled() instead of desc->status, which will
> go away.
>
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc: David Daney<ddaney@caviumnetworks.com>

Tested by: David Daney<ddaney@caviumnetworks.com>

This seems good to me.



> ---
>   arch/mips/cavium-octeon/octeon-irq.c |   71 ++++++++---------------------------
>   1 file changed, 17 insertions(+), 54 deletions(-)
>
.
.
.
