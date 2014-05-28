Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 01:18:39 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:38892 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854785AbaE1XShY8xQx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 01:18:37 +0200
Received: by mail-wg0-f48.google.com with SMTP id k14so7752426wgh.19
        for <linux-mips@linux-mips.org>; Wed, 28 May 2014 16:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type;
        bh=rh6ZKdTroNNqy+5RPTaOOwwtdIVn4HYA2Pa2Wc94BjQ=;
        b=How1IfdQTWPZMCJmPBS3IrORpaCdixoZiNS8AH/NtaNZvLYEnrAiQSoFCDcscVrHvd
         WiKM35yl8MEWJRbx+Mq1B0OfKsTYw2LkBTS01H7PfOj/KWqqmRJ7g0oVQ+onG+W7sVB7
         UwqjoWxC072DNeF83uF5Kt8Ean9lrz9A4IIrqpU0xqxdUDdAmw5VJW+XdoHhTPPyILZY
         iwYtDoeVALxuAnrn/iUb6rDIeATFB5WOpi2LhfuZq04nbyMmfuLSqWece0lTS/uCs5M3
         ElGTDOUTbe484KUx+Tberre7n4cd5uHcC0bBC1uvjETgY3o1P71pfjdCEHdPKTrywkw3
         YkAw==
X-Gm-Message-State: ALoCoQkJJAzgF6Q8lWbBsR63V895mu5zNv0fNzw+6U06HCQ1Je3bPhuWsswfCXqXCX0vPqOdDYv6
X-Received: by 10.180.73.201 with SMTP id n9mr5389116wiv.45.1401319111475;
        Wed, 28 May 2014 16:18:31 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id qq5sm20645456wic.10.2014.05.28.16.18.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 16:18:30 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org
Subject: Re: [PATCH 15/15] MIPS: paravirt: Provide _machine_halt function to exit VM on shutdown of guest
Date:   Thu, 29 May 2014 00:18:26 +0100
Message-ID: <3222538.mhZJm7FgWx@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.12.5 (Linux/3.15.0-rc7+; KDE/4.12.5; x86_64; ; )
In-Reply-To: <20140528220418.GA6335@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <537CADD1.5020006@imgtec.com> <20140528220418.GA6335@alberich>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thursday 29 May 2014 00:04:18 Andreas Herrmann wrote:
> On Wed, May 21, 2014 at 02:44:49PM +0100, James Hogan wrote:
> > On 20/05/14 15:47, Andreas Herrmann wrote:
> > > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > 
> > Does it make sense to provide a _machine_restart too?
> 
> Hmm, I've not seen a real need for this so far.
> (Halting the guest and relaunching it from the shell with lkvm was fast
> enough for my tests ;-)
> 
> But it's worth to get it working. I might be wrong but I think that
> this requires lkvm changes to actually handle the reboot.

Fair enough. No point implementing something that can't be used/tested yet. If 
QEMU gets support for paravirt, it can be done then.

Cheers
James
