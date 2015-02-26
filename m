Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 19:23:53 +0100 (CET)
Received: from mail-qg0-f46.google.com ([209.85.192.46]:59840 "EHLO
        mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007414AbbBZSXvc4QwA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 19:23:51 +0100
Received: by mail-qg0-f46.google.com with SMTP id z107so10035745qgd.5
        for <linux-mips@linux-mips.org>; Thu, 26 Feb 2015 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TEBUrtp2Ek/+c6woSt6j/JQxYxJz4RVb+boTLkzigmI=;
        b=Xv/aQbno/2exgDgoXize0iRy/Qtiy8eFDnFWKnfUx1cOIjDNbXe0x+apd6FPVoaMPP
         tidkLG5GN2h8tnRsRbtliY6kg2zxgS96OElcE6Sjp63ZcSqP8Plck+iUBJ2f/3K/RvG4
         i3jLqejnn2Pb3u7JJTvmAx0fKpZj+4UJbBjxz8U2pCcQYcpgxhxbnh0VSZtpQxisHCB5
         ixVGFYg8Z1kslykBi2UyN/hZOjxXSPYYgxqtII1Rsu7yyw64jparaBRfdhxm6ayFkUxW
         +zYdVJASo9CyVbDlDkVrLUxYZVI3y7PIq//4sjxhBTa4iTOeVIbUFOWdF4UkYzRfuSCm
         wfgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TEBUrtp2Ek/+c6woSt6j/JQxYxJz4RVb+boTLkzigmI=;
        b=H3Xbms6AAGl/Z2MhG3rMzzAlQLjf2NQQn0PEnEBiEFxA4AJYJtydPXv4RJJD889tko
         JHVYFs9BpzUZiV6rnm/JvFwPWvIsaO5T/AVKtxnnkXiXL419ixUBfhcw0v4RvLmkjb0Q
         7tFp75zDnBoITN8yZf+3o6XOK+bVh1CkDu+EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TEBUrtp2Ek/+c6woSt6j/JQxYxJz4RVb+boTLkzigmI=;
        b=Vql6emVec5Joa67b92RocDzer/3hFE0tCZC7eToOVSRk38t2Lv+lvaz59L9l+tqITS
         ZCUYusdZmkQOvNCEx3WaAOGuLcraSdzb+jqmgndts0j63q3iDtM+dhNv7LDMr2eUvZnA
         MxE5A5iUpXNVT6qVDxdQFTks8BmYY4nP7F9iLp3FOaYCs2ItJehf4mxZyDHiuKp4O6OY
         kVORjlJ0QHpNT+zxvjfBPccr2ZKPptxoG7zG3zuBSZ/IT36Em1QPm8pmo/72Ipje0IVi
         aBS+oIZQL1M4E1lXLagd4OFQrQy427OnouxE5aKPgA2hkijK0gal8Vi42RTInTE2RW9h
         gzUA==
X-Gm-Message-State: ALoCoQn2YLhBK1bUylxNc10WqqGkVpGexiooEJMgVu+PpN7XXLaXFCIysGoFlSwi4qdKD13oOCJd
MIME-Version: 1.0
X-Received: by 10.140.151.13 with SMTP id 13mr21382746qhx.68.1424975026130;
 Thu, 26 Feb 2015 10:23:46 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Thu, 26 Feb 2015 10:23:45 -0800 (PST)
In-Reply-To: <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
        <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
Date:   Thu, 26 Feb 2015 10:23:45 -0800
X-Google-Sender-Auth: fs97MwRHDPkhl8UXt6yCTnlQSoI
Message-ID: <CAL1qeaGT9DGnVN4Lg0McCESxuwphLFuoo1m96H5nauRcyF24xg@mail.gmail.com>
Subject: Re: [U-Boot] MIPS UHI spec
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, cernekee@chromium.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Hi,

On Thu, Feb 26, 2015 at 4:37 AM, Daniel Schwierzeck
<daniel.schwierzeck@gmail.com> wrote:
> 2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
>> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>>> Hi Daniel,
>>>
>>> The spec for MIPS Unified Hosting Interface is available here:
>>>
>>> http://prplfoundation.org/wiki/MIPS_documentation
>>>
>>> As we have previously discussed, this is an ideal place to
>>> define the handover of device tree data from bootloader to
>>> kernel. Using a0 == -2 and defining which register(s) you
>>> need for the actual data will fit nicely. I'll happily
>>> include whatever is decided into the next version of the spec.
>
> this originates from an off-list discussion some months ago started by
> John Crispin.
>
> (CC +John, Ralf, Jonas, linux-mips)
>
>>
>> (CC +Andrew, Ezequiel, James, James)
>>
>> On the talk of DT handover, this recent patchset adding support for a
>> system doing so to Linux is relevant:
>>
>>     http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.html
>>
>> I'm also working on a system for which I'll need to implement DT
>> handover very soon. It would be very nice if we could agree on some
>> standard way of doing so (and eventually if the code on the Linux side
>> can be generic enough to allow a multiplatform kernel).

+1.  I would like to see this happen as well.

> to be conformant with UHI I propose $a0 == -2 and $a1 == address of DT
> blob. It is a simple extension and should not interfere with the
> various legacy boot interfaces.
>
> U-Boot mainline code is almost ready for DT handover. I have prepared
> a patch [1] which completes it by implementing my proposal.

Hmm... we decided to follow the ARM convention here ($a0 = 0, $a1 =
-1, $a2 = physical address of DTB), which is also what the BMIPS
platform (submitted by Kevin) is using for DT handover.  Is there
already a platform using the protocol you described?  It's still early
enough that we could change the DT handover for Pistachio, but it
would be good to agree on something soon.

Thanks,
Andrew
