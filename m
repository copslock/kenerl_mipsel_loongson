Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 12:21:48 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:63547 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493390Ab1AQLVc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 12:21:32 +0100
Received: by qwj9 with SMTP id 9so4573018qwj.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=0z3063EbFr5GBNY1A8Am9EQqA1xaRPxrkBy7SODDG/E=;
        b=vKGSzCdNCMALg5/AQtgWBjql1ebAbNGrA1IGPq4LhIdGtJ8TbQPe05I38Znk4usoc6
         wG2irKOeeRIqLIZ9cJQvnMG7IG0Q5XcYCGezciohx3ZIplsIqxl1cqwYhqY75MymXGqU
         PoRQ2kerjLS6LWRrM6wC/XA7yqAfH6mDTNlB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YLfiDrXjy8CNSkf1lnjZD2E+Fzd4DSzbQJbGPDUNiQVEp+TBWOIu+aYGa3URKGYGT+
         ipIoZenJvseQrlQp4R1BiVzwrhhn+1OJLCYQ8HmOPtw5JHSoQnd/9eLLbmISgbJXmnGD
         eHaZXYgZlnc34QcoqaqE8q+yfwNh0CvfruAT8=
Received: by 10.229.188.68 with SMTP id cz4mr3472822qcb.261.1295263286057;
 Mon, 17 Jan 2011 03:21:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.39.9 with HTTP; Mon, 17 Jan 2011 03:21:05 -0800 (PST)
In-Reply-To: <1295261783.24530.3.camel@maggie>
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com> <1295261783.24530.3.camel@maggie>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 17 Jan 2011 12:21:05 +0100
Message-ID: <AANLkTikJcug7LUTgX_YDD4Z8ZBrdkAdLq8_Epa6TkA5f@mail.gmail.com>
Subject: Re: Merging SSB and HND/AI support
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <mb@bu3sch.de>
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips

On 17 January 2011 11:56, Michael Büsch <mb@bu3sch.de> wrote:
> On Mon, 2011-01-17 at 11:46 +0100, Jonas Gorski wrote:
>> a) Merge the HND/AI code into the current SSB code, or
>>
>> b) add the missing code for SoCs to brcm80211 and replace the SSB code with it.
>
> Why can't we keep those two platforms separated?
> Is there really a lot of shared code between SSB and HND/AI?

Yes, as far as I understand the AI bus behaves mostly like a SSB bus
except for places like enabling/disabling cores. E.g. the AI bus also
has a common core, which has a bit for telling whether its a SSB or AI
bus, and has the mostly the same registers as the SSB common cores (so
most driver_chipcommon_* stuff also applies for the AI bus).

> It's true that there's currently a lot of device functionality built
> into ssb. Like pci bridge, mips core, extif, etc...
> If you take all that code out, you're probably not left with anything.

That's because most shared code isn't in brcm80211, but only found in
the SDKs for the SoCs.

> So why do we need to replace or merge SSB in the first place? Can't
> it co-exist with HND/AI?

It probably can, but then the SSB code must be at least made AI aware
so it doesn't try to attach itself if it finds one. Also I don't know
if it is a good idea to let arch-specific code depend on code in
staging.

Jonas
