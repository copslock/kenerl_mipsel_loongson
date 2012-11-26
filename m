Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2012 19:58:31 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38065 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825876Ab2KZS5R2NFXz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2012 19:57:17 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi1so4763439pad.36
        for <multiple recipients>; Mon, 26 Nov 2012 10:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kGiVQDu8QtdYvEIRCj4qFSpmseQRs/CfP7+9WmCsusM=;
        b=tAJFPd15vH37tjK/K4YdfNkDmRMO21NTcvJCDkMVdbPzzTmVw6w+zDBxgzWo/mJnkJ
         cbJUwZMTgS7tVl1CFdvVWvVhPZI7+25gcvKoAZx+oE71gqdts8bs5R5eEqIKEkMUSUeR
         sWfIFBZWkrTAG4YNsSyjH4mT/8gpBPXqSycdcDYWueVokfgQdCcJBjXEjAhjQtvMJYHl
         JtJ9QhXi17/0SxXAK8QVv5PIhTOR9GPUcXTZ/gj3nnah779CwiQ8Mgv4Smgxn0aYpDzB
         zVKX14NAou66MAntLtqgDw3zLaxOpbG3DJLpn4WPEpjBdZK6NRiCY08R3GPegB8etsEm
         Y98A==
Received: by 10.66.78.67 with SMTP id z3mr35235241paw.33.1353956035348;
        Mon, 26 Nov 2012 10:53:55 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id tm5sm9164211pbc.64.2012.11.26.10.53.52
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Nov 2012 10:53:53 -0800 (PST)
Message-ID: <50B3BAC0.6070407@gmail.com>
Date:   Mon, 26 Nov 2012 10:53:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 00/18] KVM for MIPS32 Processors
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35130
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


I have several general questions about this patch...

On 11/21/2012 06:33 PM, Sanjay Lal wrote:
> The following patchset implements KVM support for MIPS32R2 processors,
> using Trap & Emulate, with basic runtime binary translation to improve
> performance.  The goal has been to keep the Guest kernel changes to a
> minimum.

What is the point of minimizing guest kernel changes?

Because you are using an invented memory map, instead of the 
architecturally defined map, there is no hope of running a single kernel 
image both natively and as a guest.  So why do you care about how many 
changes there are.

>
> The patch is against Linux 3.7-rc6.  This is Version 2 of the patch set.
>
> There is a companion patchset for QEMU that adds KVM support for the
> MIPS target.
>
> KVM/MIPS should support MIPS32-R2 processors and beyond.
> It has been tested on the following platforms:
>   - Malta Board with FPGA based 34K (Little Endian).
>   - Sigma Designs TangoX board with a 24K based 8654 SoC (Little Endian).
>   - Malta Board with 74K @ 1GHz (Little Endian).
>   - OVPSim MIPS simulator from Imperas emulating a Malta board with
>     24Kc and 1074Kc cores (Little Endian).

Unlike x86, there is no concept of a canonical MIPS system for you to 
implement.  So the choice of emulating a Malta or one of the 
SigmaDesigns boards doesn't seem to me to give you anything.

Why not just define the guest system to be exactly the facilities 
provided by the VirtIO drivers?


[...]


Perhaps it is obvious from the patches, but I wasn't able to figure out 
how you solve the problem of the Root/Host kernel clobbering the K0 and 
K1 registers in its exception handlers.  These registers are also used 
by the Guest kernel (aren't they)?

David Daney
