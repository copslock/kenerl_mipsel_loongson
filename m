Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 23:41:31 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33933 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012379AbcBIWl3lFXTD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 23:41:29 +0100
Received: by mail-pa0-f43.google.com with SMTP id kp3so969312pab.1;
        Tue, 09 Feb 2016 14:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=KcMTmf4y73NdCeVoXns7ImMjG0vDp3PIqO0fjXbyWC0=;
        b=EvBFJqT1WdzupcooHxt+cEy8rVqAUxAXmhsSNeXUmzJAvNVRGO2ZgtGU9rnPyzRkil
         E7BwbYLZxpqqv5MshJBkIbt0GFb/iFJQPJSEGrlLTC7/DzYFJxSa2g9AC95sdonZpkF7
         0TA3aIXxzKznT2eUedA5jDQGc9Sm5A71xVWH8sWVwHAphDm1i5c1KArfNgX5460hUzL6
         aS71hAAzsqhMlbJF4hl98HBQYtZOfB3SNGkr1Kmd1L/D0X4IJlsxjy/in6f/FmdQKCTd
         wTaGxdnzLt5B1Pzd5u5iwK05jiZJOUP87q6sUlcxtGIKITTLDNmBRnMOk4h/50b81VZV
         6FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KcMTmf4y73NdCeVoXns7ImMjG0vDp3PIqO0fjXbyWC0=;
        b=QyvVvwVlHajET8del5KAmrLaUkTw3kp6JZROJLlqhWetjzdoOSSW2QcJLsGDYAwf4A
         1VroBteYCfrutZncyEVXmerODj3jfTAH6q4PfQZ6gWFfUk8Rp7xD4moKKK1SLxu3Rxev
         DmywiWBGO3aPTHJPca7gp4LVHaO3aNGkxe9ACVSQnB1xe9cq/45rrJW/rw430YFCzRB8
         i8TWkPJ7yXgUYojkVHOqP3Fjrv0JMKuk1NP5kDMgHBTBGXkvvC1qjWKs4BPiQ2YVf9QR
         8rMvVgdIZWQ81N1AhDObkX/uoMKY+zQ5pJKmD2m4R71sJ4IrjA5/CcVjV6K7op+ZO//2
         w9ww==
X-Gm-Message-State: AG10YORDVlvBbk7AEfZ7/AOGiRqgOrcNyJq7RPa4Wrf5lyiwQFbutf3ltBvrLYuhYxUBBw==
X-Received: by 10.66.102.106 with SMTP id fn10mr54759030pab.60.1455057683668;
        Tue, 09 Feb 2016 14:41:23 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id 6sm152841pfo.58.2016.02.09.14.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 14:41:23 -0800 (PST)
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
 <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
 <alpine.DEB.2.00.1602092101240.15885@tp.orcam.me.uk>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        blogic@openwrt.org, cernekee@gmail.com, jon.fraser@broadcom.com,
        pgynther@google.com, paul.burton@imgtec.com, ddaney.cavm@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56BA6AD3.9050308@gmail.com>
Date:   Tue, 9 Feb 2016 14:40:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602092101240.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51931
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

On 09/02/16 13:19, Maciej W. Rozycki wrote:
> On Tue, 9 Feb 2016, Florian Fainelli wrote:
> 
>> +static void bmips5000_pref30_quirk(void)
>> +{
>> +	__asm__ __volatile__(
>> +	"	.word	0x4008b008\n"	/* mfc0 $8, $22, 8 */
>> +	"	lui	$9, 0x0100\n"
>> +	"	or	$8, $9\n"
>> +	/* disable "pref 30" on buggy CPUs */
>> +	"	lui	$9, 0x0800\n"
>> +	"	or	$8, $9\n"
>> +	"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
>> +	: : : "$8", "$9");
>> +}
> 
>  Ouch, why not using our standard accessors and avoid magic numbers, e.g.:

Are you positive the assembler will not barf on these custom cp0 reg 22
selectors?

> 
> #define read_c0_brcm_whateverthisiscalled() \
> 	__read_32bit_c0_register($22, 8)
> #define write_c0_brcm_whateverthisiscalled(val) \
> 	__write_32bit_c0_register($22, 8, val)
> 
> #define BMIPS5000_WHATEVERTHISISCALLED_BIT_X 0x0100
> #define BMIPS5000_WHATEVERTHISISCALLED_BIT_Y 0x0800
> 
> static void bmips5000_pref30_quirk(void)
> {
> 	unsigned int whateverthisiscalled;
> 
> 	whateverthisiscalled = read_c0_brcm_whateverthisiscalled();
> 	whateverthisiscalled |= BMIPS_WHATEVERTHISISCALLED_BIT_X;
> 	/* disable "pref 30" on buggy CPUs */
> 	whateverthisiscalled |= BMIPS_WHATEVERTHISISCALLED_BIT_Y;
> 	write_c0_brcm_whateverthisiscalled(whateverthisiscalled);
> }
> 
> ?  I'm leaving it up to you to select the right names here -- just about 
> anything will be better than the halfway-binary piece you have proposed.

These are not standardized registers in any form, which is why these are
in a halfway-binary form, they are not meant to be re-used outside of
two known places: disabling pref30 and enabling "rotr".

> 
>  FYI, we already have BMIPS5000 accessors defined up to ($22, 7) in 
> <asm/mipsregs.h> so it will be the right place for the new ones as well.
> 
>   Maciej
> 


-- 
Florian
