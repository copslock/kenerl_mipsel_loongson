Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2012 18:36:51 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:60054 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825747Ab2J3Rgtx14kG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2012 18:36:49 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so303839pad.36
        for <multiple recipients>; Tue, 30 Oct 2012 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IjJzVNCQ+7q0pFvHQOGitQH/+Rt05/0ajGokYsv2UtE=;
        b=eBON5ZKnlcdYPB/0VPLK5XbGlaeHp4K1wdAouv2xWlYxPDwNZsFHxA/pjQMLEss1vM
         FLqrS1gxTuSE+yaqzwG9ujtXLAP7dVzqmiBAOYWh1TXBOW4Gr5G605ROZIDL38oF8hf1
         4OO8S4+YU+9Ly+YOp+Rm6iyJQiFtqqNAvj7e/lkRtOug4Ra1o+b5tHAjOvrB87tMT/bz
         FJ8gMwXmn/Jfc7JcBjbtmC7cbpxVToNQtrKDe/E/YvUfUaT3VvFITox+h/aIw7dQKA3k
         JXo1zBIY8sEnmZd0KLJ7cLIDyWyfjP1CerlzYmX4HErdsfwTeJCK6dzJHC9k9z7YCcxI
         etpQ==
Received: by 10.68.217.67 with SMTP id ow3mr105166563pbc.26.1351618603308;
        Tue, 30 Oct 2012 10:36:43 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ok8sm844423pbb.42.2012.10.30.10.36.39
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 10:36:41 -0700 (PDT)
Message-ID: <50901027.6090802@gmail.com>
Date:   Tue, 30 Oct 2012 10:36:39 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     "Jayachandran C." <c.jayachandran@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Jacob Burkholder <jacob.burkholder@blinqnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: linux 3.6.3 mips64 mtd jffs2 unmount issue
References: <14A0B61B8C8EFA4A9F40381A10D219104EEB0F5226@IAD2MBX02.mex02.mlsrvr.com> <CA+7sy7CWkcsg9YffJ-rcdN7D=vZtuees31upGzgUya5puDN0og@mail.gmail.com>
In-Reply-To: <CA+7sy7CWkcsg9YffJ-rcdN7D=vZtuees31upGzgUya5puDN0og@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/30/2012 01:09 AM, Jayachandran C. wrote:
[...]

>
> We had seen the same issue here, and worked around it the same way
> (i.e use dynamic allocation for the backing dev structures).
>
> I ran across a similar issue in using built-in DTB (basically, kernel
> data address does not work for virt_to_phys/phys_to_virt in 64-bit
> when the load address is in CKSEG0).  There I did something like this:
>
> ptr = phys_to_virt(__pa(kernel_data_ptr));
>
> This works since __pa knows about CKSEG0 addresses in 64bit.
>
>

Really the proper fix is to make virt_to_phys() work.  This isn't the 
only case where we have seen failures due to this issue:


http://www.linux-mips.org/archives/linux-mips/2011-09/msg00029.html

I fixed it like this...

In io.h:

static inline unsigned long virt_to_phys(volatile const void *address)
{
	return __pa(address);
}

Really this needs to be pushed upstream by somebody.

> JC.
>
>
>
