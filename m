Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 12:35:34 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33771 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010866AbbAILfcMgLNi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 12:35:32 +0100
Received: by mail-lb0-f174.google.com with SMTP id 10so8219315lbg.5
        for <linux-mips@linux-mips.org>; Fri, 09 Jan 2015 03:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1Z/o8RbowAKsKj+bkwl+TO+waCJV0ioyIECAUjUNUZg=;
        b=nNzOL+6xlsUCVOuLSnPbx84tHJ1b3itvUDDxDjYcEBLg8C7690OGEhFD3BaiTxlgHO
         VMK9atfKZW09s0MLItWM/HzlEZTT2h0i4XcOYY5Sdh460aviBGtsfgcchb8qGQIeCZ3w
         QF0zGsR/e23qY50UFe9oixJwcf1xNaSfL+Wd6BNDmcZ/DNSPAu5ryIcBp9l4HH++0but
         QnayxcxNFTe+kgAwKD94DOmdZKs/68gMyPW8UOm97f8FMumSUCQXFGxBwwQg6Z8QX73H
         d1bsAkoQMp5lBm1AXVUZwiN71negKmJZJ3lidc+prHVjlMTDuKPveGHRtG6EabramdXQ
         tNOQ==
X-Gm-Message-State: ALoCoQndq3LcWtBroUNJD1heypX45vwm/22JxYfminociY5APV/JXmdYPLVq8wMIvKC4vqWUCEp3
X-Received: by 10.152.43.77 with SMTP id u13mr12687164lal.93.1420803326452;
        Fri, 09 Jan 2015 03:35:26 -0800 (PST)
Received: from [192.168.3.68] (ppp18-134.pppoe.mtu-net.ru. [81.195.18.134])
        by mx.google.com with ESMTPSA id l3sm1815455lbs.13.2015.01.09.03.35.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2015 03:35:25 -0800 (PST)
Message-ID: <54AFBCFD.2020104@cogentembedded.com>
Date:   Fri, 09 Jan 2015 14:35:25 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     "Jayachandran C." <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 04/17] MIPS: Netlogic: Disable writing IRT for disabled
 blocks
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com> <1420630118-17198-5-git-send-email-jchandra@broadcom.com> <54AD67EF.2080406@cogentembedded.com> <20150109094818.GA18823@jayachandranc.netlogicmicro.com>
In-Reply-To: <20150109094818.GA18823@jayachandranc.netlogicmicro.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 1/9/2015 12:48 PM, Jayachandran C. wrote:

>>> If the device header of a block is not present, return invalid IRT
>>> value so that we do not program an incorrect offset.

>>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>>> ---
>>>   arch/mips/netlogic/xlp/nlm_hal.c | 25 ++++++++++++++++---------
>>>   1 file changed, 16 insertions(+), 9 deletions(-)

>>> diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
>>> index 7e0d224..de41fb5 100644
>>> --- a/arch/mips/netlogic/xlp/nlm_hal.c
>>> +++ b/arch/mips/netlogic/xlp/nlm_hal.c
>>> @@ -170,16 +170,23 @@ static int xlp_irq_to_irt(int irq)
>>>   	}
>>>
>>>   	if (devoff != 0) {
>>> +		uint32_t val;
>>> +
>>>   		pcibase = nlm_pcicfg_base(devoff);
>>> -		irt = nlm_read_reg(pcibase, XLP_PCI_IRTINFO_REG) & 0xffff;
>>> -		/* HW weirdness, I2C IRT entry has to be fixed up */
>>> -		switch (irq) {
>>> -		case PIC_I2C_1_IRQ:
>>> -			irt = irt + 1; break;
>>> -		case PIC_I2C_2_IRQ:
>>> -			irt = irt + 2; break;
>>> -		case PIC_I2C_3_IRQ:
>>> -			irt = irt + 3; break;
>>> +		val = nlm_read_reg(pcibase, XLP_PCI_IRTINFO_REG);
>>> +		if (val == 0xffffffff) {
>>> +			irt = -1;
>>> +		} else {
>>> +			irt = val & 0xffff;
>>> +			/* HW weirdness, I2C IRT entry has to be fixed up */
>>> +			switch (irq) {
>>> +			case PIC_I2C_1_IRQ:
>>> +				irt = irt + 1; break;
>>> +			case PIC_I2C_2_IRQ:
>>> +				irt = irt + 2; break;
>>> +			case PIC_I2C_3_IRQ:
>>> +				irt = irt + 3; break;

>>     Why not 'irt += n' in all 3 cases?
>>     And don't place *break* on the same line -- this upsets checkpatch.pl IIRC.

> checkpatch did not complain,

    Hm, perhaps this specific check was removed recently...

> and also I did not want to mix formatting
> change with actual fix.

    Ah, I didn't realize you were just moving the code.

> But agree that the code can cleaned up a bit.
> I will sent out a patch for this next cycle.

    TIA. :-)

> JC.

WBR, Sergei
