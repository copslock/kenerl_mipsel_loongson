Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 17:06:46 +0200 (CEST)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:55367 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818323Ab3ILPGkT09-q convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Sep 2013 17:06:40 +0200
Received: by mail-pb0-f41.google.com with SMTP id rp2so10768422pbb.28
        for <multiple recipients>; Thu, 12 Sep 2013 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JtW0CdV+NLubnI6CBQWZ5CbEwmxEbOlgkdw/KQ7NheM=;
        b=uFoWuM8W5eqEAhsJOKrIJGpZHjW4gGjweLGukuG9cspkdwVVTEINA794sWcaVWEWsn
         hNp2vJJxo26oyFCUNyyMGm1LKj9JRtY70HvVcGeLuk6oROWeKkGNMMLDumVRBp1PmWFA
         cOfVKgUUCjeFgvrgfT18kaeN0m2azAvQD2Q4LUMSScARnV2OprCVs9WjLowH2tKU0GAw
         MCgoBp1WbkTXPTqV2bUtRlwWxAQTY4pSFYF7ZB+LYJSzgOXwbHTQmf3e5EPS9vVUqFOZ
         gOBGYd0c2wYxVIoV29oygi2/v+ElitN132UPAOP+dUGhfs6uMdU5CsDMRtJx70YafVmF
         kXBw==
X-Received: by 10.68.241.6 with SMTP id we6mr3403697pbc.174.1378998393547;
 Thu, 12 Sep 2013 08:06:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.38.99 with HTTP; Thu, 12 Sep 2013 08:05:53 -0700 (PDT)
In-Reply-To: <j0d17e3bxlvp3famj4e32xv9.1378997855738@email.android.com>
References: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com>
 <52318BC6.7030903@imgtec.com> <j0d17e3bxlvp3famj4e32xv9.1378997855738@email.android.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 12 Sep 2013 16:05:53 +0100
Message-ID: <CAGVrzcY_OWUSK4dfZ8fnV49ELSYE6exSYQi5AwxuGoKnvx5Rtg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix errata for some 1074K cores.
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Paul Burton <Paul.Burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/9/12 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>:
> Treat it as is.
>
> It is a dirty laundry of HW engineers and you may need to communicate with them or read Errata docs on CPU.
>
> If it is about a way how it is written - ask Steven, initially it was in mainland probe code but he think it should be a separate function. I just corrected him, pointing that erratas on 74K and 1074K are different. But because he insist on having the same CPU_74K for both, so...

If you take a look at another CPU company such as ARM, they provide
lengthy explanations for their various Erratas:

config PJ4B_ERRATA_4742
        bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the
CPU Core to Cease Operation"
        depends on CPU_PJ4B && MACH_ARMADA_370
        default y
        help
          When coming out of either a Wait for Interrupt (WFI) or a Wait for
          Event (WFE) IDLE states, a specific timing sensitivity exists between
          the retiring WFI/WFE instructions and the newly issued subsequent
          instructions.  This sensitivity can result in a CPU hang scenario.
          Workaround:
          The software must insert either a Data Synchronization Barrier (DSB)
          or Data Memory Barrier (DMB) command immediately after the WFI/WFE
          instruction

I really think that you should aim for the same level of information
so that people know whether this is relevant for their platform,
whether they have the ECO applied etc...
-- 
Florian
