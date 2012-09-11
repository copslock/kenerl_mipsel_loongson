Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 03:28:10 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:39299 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903487Ab2IKB2F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 03:28:05 +0200
Received: by pbbrq8 with SMTP id rq8so80753pbb.36
        for <linux-mips@linux-mips.org>; Mon, 10 Sep 2012 18:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=p4PjrGXx3lKLKp2kQnzLpCiIVrj9McRvZZ4761IaWAQ=;
        b=ucoG0MgH+9kaDRxQSpCOmglFe+uxWtSiMJ9FaJFL5iDrzJ3SfHyIO+6b8XaqnZ+KNv
         dmjlrgWnH8URWtNYXPXWsskei8jeV1W0/uMW1beTarcYkuW3IEaGyjfn53+ow5quBkUm
         R77RY5rFkaffAEpfrjexBFGKeZWp6WyGH6/+//Ki5N2k5nkFliTX+kKcSYwzLvHUIOzL
         Cta6pPKxhFdPpR7PkXHdQp3MUO87gsyWNBQP5Ay21X11oCJvd7TqBMXwQjg85fbKhSPL
         ehE3GbkPM734PdHeS5fkexap6cGCYg5oFH6fWR7i+Up+VSjKROT+YGOc9rby/AYGwL1B
         diWw==
Received: by 10.66.89.37 with SMTP id bl5mr24563085pab.55.1347326878848;
        Mon, 10 Sep 2012 18:27:58 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id qf4sm8973626pbc.1.2012.09.10.18.27.55
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Sep 2012 18:27:56 -0700 (PDT)
Message-ID: <504E939B.5060209@gmail.com>
Date:   Mon, 10 Sep 2012 18:27:55 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@paralogos.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
References: <20120909193008.GA15157@brightrain.aerifal.cx> <20120910170830.GB24448@linux-mips.org> <20120910172248.GN27715@brightrain.aerifal.cx> <alpine.LFD.2.00.1209110059580.8926@eddie.linux-mips.org> <504E8E27.5030904@paralogos.com>
In-Reply-To: <504E8E27.5030904@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34461
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

On 09/10/2012 06:04 PM, Kevin D. Kissell wrote:
> On 09/10/2012 05:29 PM, Maciej W. Rozycki wrote:
>> I do wonder however why we have these instructions to save/restore $25
>> in SAVE_SOME/RESTORE_SOME. This dates back to 2.4 at the very least.
>> Ralf, any insights?
> Hi, guys.  Maybe the fact that it's used for dispatching PIC calls has
> something to do with it?
>

I don't think so.  It is call clobbered in all Linux ABIs.  So there is 
never a need to save it.  It even has the pseudonym of $t9 indicating 
that it will get clobbered.

The other call clobbered registers that happen to be saved are for the 
nefarious uses of the kernel itself (a0..a6 for system call restarting), 
I think this is just left over cruft.

David Daney


> /K.
>
>
>
>
