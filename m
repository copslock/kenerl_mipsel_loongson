Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 18:28:52 +0100 (CET)
Received: from mail-qc0-f173.google.com ([209.85.216.173]:34904 "EHLO
        mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007622AbbB0R2u3Td8Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 18:28:50 +0100
Received: by qcyl6 with SMTP id l6so15075004qcy.2
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 09:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dDB5fh6NdmUIS8iDI0FIA61kw1Sx4fsd2jOGrP2QZhA=;
        b=FCW/ARaW6xWqIzCkL0D9O70Y5ugDJm3v6V3Ww7tbaaUtH85xGeJSLT55hJOzrPZr+h
         ZXTVdmE/+4Csr+phFwQzKokETlzaaxq64MNP0V860dMKn/0ZfhPM4JMRXWDhEjeei4qE
         CtCUjb6FJbpBUD7Nt3CQdKf/Ide7wJyyTDDyB7+XNYf8KTZn2XsFoJ2SznstIGsQ8xUX
         Sr3glh4V624U0CZ46IgrJushpzAqVioAE4T1ANByoL5N2xYxIytwKP6v3VaODFsdo02F
         ru4blTVE9hw2YW8eFu1FiVZBp9oRJ7hHZGwS/DmtEFkEN2f2TWivKZzGQ4YK4xWFRgxo
         6vaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dDB5fh6NdmUIS8iDI0FIA61kw1Sx4fsd2jOGrP2QZhA=;
        b=SulVVebJq7l0Spse/7yc27+9j4kI//6Q+nUMnfiFzPuU9gpT20tRvy1ENIMveaE1Xo
         zaCEC1GWzk0tVJSaWPuSISU5I/SHSNPsr7aJH8nSv3QBs3ZdMj1L+kuWbfXWQW3JM7oC
         KHz6AAa6OYTyF7LyrKLb7TKmCX55QTS9BoUHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dDB5fh6NdmUIS8iDI0FIA61kw1Sx4fsd2jOGrP2QZhA=;
        b=ZefZQ8mMH/eK1EYgJnpOiqx36EH7oeI4gx76fv7oOJPEbpjnz3h5od6gyOlsljhQly
         OrgWTVgkY8O91JAqL2G2CaV1ILhRpCGpWua/qz8JWCfuVaA5AQ1eAA9lGUJZjzLmjPzK
         8Z4eYfG8iMyiWTNuj+eGcv5COs0t0SIae/pXv0F41/yA9xgIihB7AOjYZ/GZQF8ZBsWt
         ResPJfPuK3jbgnZ0t8Pp11BIEXrrqGyPVsZxcT/GxFWnamBx+/qp/Sr0EU7wgSuGDabn
         Qa8ZlJan1JH6ofG1aWnwB7MBSR6C7MW4i3DXAVPB5GIzZmU3oc/ugIlvwMnoTnqXVF/L
         JTUw==
X-Gm-Message-State: ALoCoQmoFIEIddv7UTa+cJHo1QQIAMvmsxYchhjY7YwOLsCAM3DpjaEztpHGbVwPNTff7AYN09Li
MIME-Version: 1.0
X-Received: by 10.140.31.116 with SMTP id e107mr3964432qge.36.1425058124944;
 Fri, 27 Feb 2015 09:28:44 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Fri, 27 Feb 2015 09:28:44 -0800 (PST)
In-Reply-To: <CACUy__UdCSMW4cLDKMvu3CLBeaKpSbJ19zCMP29hwT+T_y7q4g@mail.gmail.com>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
        <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
        <CAL1qeaGT9DGnVN4Lg0McCESxuwphLFuoo1m96H5nauRcyF24xg@mail.gmail.com>
        <CACUy__UdCSMW4cLDKMvu3CLBeaKpSbJ19zCMP29hwT+T_y7q4g@mail.gmail.com>
Date:   Fri, 27 Feb 2015 09:28:44 -0800
X-Google-Sender-Auth: bBelT8JZd-OHmicc3tUcusE2hdM
Message-ID: <CAL1qeaGsNZE0arPSpQykDoxDiwFpSuLQopvqts4MsQ6BT3VeEw@mail.gmail.com>
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
X-archive-position: 46048
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

On Fri, Feb 27, 2015 at 2:44 AM, Daniel Schwierzeck
<daniel.schwierzeck@gmail.com> wrote:
> 2015-02-26 19:23 GMT+01:00 Andrew Bresticker <abrestic@chromium.org>:
>> Hi,
>>
>> On Thu, Feb 26, 2015 at 4:37 AM, Daniel Schwierzeck
>> <daniel.schwierzeck@gmail.com> wrote:
>>> 2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
>>>> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> The spec for MIPS Unified Hosting Interface is available here:
>>>>>
>>>>> http://prplfoundation.org/wiki/MIPS_documentation
>>>>>
>>>>> As we have previously discussed, this is an ideal place to
>>>>> define the handover of device tree data from bootloader to
>>>>> kernel. Using a0 == -2 and defining which register(s) you
>>>>> need for the actual data will fit nicely. I'll happily
>>>>> include whatever is decided into the next version of the spec.
>>>
>>> this originates from an off-list discussion some months ago started by
>>> John Crispin.
>>>
>>> (CC +John, Ralf, Jonas, linux-mips)
>>>
>>>>
>>>> (CC +Andrew, Ezequiel, James, James)
>>>>
>>>> On the talk of DT handover, this recent patchset adding support for a
>>>> system doing so to Linux is relevant:
>>>>
>>>>     http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.html
>>>>
>>>> I'm also working on a system for which I'll need to implement DT
>>>> handover very soon. It would be very nice if we could agree on some
>>>> standard way of doing so (and eventually if the code on the Linux side
>>>> can be generic enough to allow a multiplatform kernel).
>>
>> +1.  I would like to see this happen as well.
>>
>>> to be conformant with UHI I propose $a0 == -2 and $a1 == address of DT
>>> blob. It is a simple extension and should not interfere with the
>>> various legacy boot interfaces.
>>>
>>> U-Boot mainline code is almost ready for DT handover. I have prepared
>>> a patch [1] which completes it by implementing my proposal.
>>
>> Hmm... we decided to follow the ARM convention here ($a0 = 0, $a1 =
>> -1, $a2 = physical address of DTB), which is also what the BMIPS
>> platform (submitted by Kevin) is using for DT handover.  Is there
>> already a platform using the protocol you described?
>
> no, but with its publication the MIPS UHI spec is kind of official.
> AFAIK patches to support UHI in gcc, gdb, U-Boot etc. are already
> submitted or prepared. Matthew suggested that new boot protocols
> should be compliant with UHI. I think the ARM convention does not fit
> to UHI.

Ok, I think we can change the boot protocol on Pistachio to match UHI then.

-Andrew
