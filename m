Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 18:45:40 +0200 (CEST)
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:59298 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007134AbbEYQpgAmzsL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 18:45:36 +0200
Received: from resomta-po-06v.sys.comcast.net ([96.114.154.230])
        by resqmta-po-05v.sys.comcast.net with comcast
        id YGlR1q0054yXVJQ01GlYut; Mon, 25 May 2015 16:45:32 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-po-06v.sys.comcast.net with comcast
        id YGlW1q00P42s2jH01GlX37; Mon, 25 May 2015 16:45:32 +0000
Message-ID: <556351A6.9080007@gentoo.org>
Date:   Mon, 25 May 2015 12:45:26 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH]: MIPS: PCI: Add pre_enable hook, minor readability fixes
References: <5562B60D.3050507@gentoo.org> <55631F26.6080108@cogentembedded.com>
In-Reply-To: <55631F26.6080108@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432572332;
        bh=ixk9N0lBqhpBIHvPRgZ0xKiG/p+TUFrQXnxhQd4Tj4I=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=YGRZnfbASxZi5OU9ttbqFRTKiOBZr54+Dl+AkhLMvb6RsR6Oucs7fRcfkzQRDRFpm
         44tvgWFRG5X28Mgkf4fhq6pW8GuS8cn1/JwgUQX6//NCV2SHmxP+b8vS6bTYGDmQGj
         1ZFTMOApAu5NdPFVkBRhK+yFWhmm6zT1L1kDYiJr+zufpsV2RcMY6EGDS4r+z2idvA
         u+ZG9Ibqhag0cXU3RqCfi+qIySVreViCKbXKv1qBH6tFwWDAKMs1YAcIr1epThEQUI
         CuHx52Cw3ccOh9cTmytRFY04EnG3sAKMVhBpC66+nl9fVnsUl+pvQTHPnqjeWwMX7u
         e53W0SxJwwSHA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 05/25/2015 09:09, Sergei Shtylyov wrote:
> Hello.
> 
> On 5/25/2015 8:41 AM, Joshua Kinard wrote:
> 
>> From: Joshua Kinard <kumba@gentoo.org>
> 
>> This patch adds a hook "pre_enable", to the core MIPS PCI code.  It is
>> used by the IP30 Port to setup the PCI resources prior to probing the
>> BRIDGE and detecting available PCI devices.  It also adds some minor
>> whitespace to improve readability.
> 
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> [...]
> 
>> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
>> index b8a0bf5..af17c16 100644
>> --- a/arch/mips/pci/pci.c
>> +++ b/arch/mips/pci/pci.c
>> @@ -261,14 +261,19 @@ static int pcibios_enable_resources(struct pci_dev
>> *dev, int mask)
>>       u16 cmd, old_cmd;
>>       int idx;
>>       struct resource *r;
>> +    struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
>>
>>       pci_read_config_word(dev, PCI_COMMAND, &cmd);
>>       old_cmd = cmd;
>> -    for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
>> +    for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
>>           /* Only set up the requested stuff */
>> -        if (!(mask & (1<<idx)))
>> +        if (!(mask & (1 << idx)))
>>               continue;
>>
>> +        if(hose->pre_enable)
>> +            if(hose->pre_enable(hose, dev, idx) < 0)
> 
>    Space required after *if*; please run your patches thru scripts/checkpatch.pl.
> 
> WBR, Sergei

Whoops, thanks for catching that!  I cleaned up a lot of the original IP30 code
and added a lot of the needed whitespace, but I apparently missed this bit.
I'll send a v2 shortly.

--J
