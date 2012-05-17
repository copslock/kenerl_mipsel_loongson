Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2012 03:51:23 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:60425 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903715Ab2ERBvQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 May 2012 03:51:16 +0200
Received: by yhjj52 with SMTP id j52so2841409yhj.36
        for <multiple recipients>; Thu, 17 May 2012 18:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=REcJyKLVETulPOxwhdFLTE2sw4PCsmxe98zTwwLUwCY=;
        b=yP2Ftdn/8FHBFpYgl5Y3EG2rN1l40ASNEpV5YjgHCCEFlWODqzc2Rva6oHkIkFNpnd
         zRSuCzk4GQHILm5a0YjqYJVM26LzWayl/epC4VXpUWso8CeLlu9HuYZX+tABGDPkCBkN
         y/ieDlhMgd7SG6OEc0J2q66PxZk9VurZwPgbQSK9Vkffze7S2nUKZW4X7GipDDyLCf0t
         aejhaPiTkG+PiHz/ji589hv7a0T51U2nnypZ1bzWWXFd+FGIzR/nyAgb8UQ9fpf/sGby
         dVG0QdRxwiHkRfzjTuXzdNYWV29skJRoPpVGiuT14VpYWF4uPiWQPG+6hQARQkiMKJvs
         gp9g==
Received: by 10.50.158.161 with SMTP id wv1mr15353191igb.43.1337305869495;
        Thu, 17 May 2012 18:51:09 -0700 (PDT)
Received: from [10.2.0.143] ([12.238.42.2])
        by mx.google.com with ESMTPS id yg9sm19515458igb.15.2012.05.17.18.51.05
        (version=SSLv3 cipher=OTHER);
        Thu, 17 May 2012 18:51:08 -0700 (PDT)
Message-ID: <4FB57862.5000700@gmail.com>
Date:   Thu, 17 May 2012 17:14:58 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        linux-mips@linux-mips.org, linux-pci@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org> <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org> <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com> <4FA32E47.7020406@gmail.com> <4FA3B596.3050106@openwrt.org> <CAErSpo4AQh3cJzULkmP_Dqsf0cSPRP1WqvhuQR3gePXw2rN7rQ@mail.gmail.com> <4FADFB39.6010100@openwrt.org>
In-Reply-To: <4FADFB39.6010100@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/12/2012 12:55 AM, John Crispin wrote:
> 
>> I compiled alpha, ia64, mips, parisc, powerpc, sh, sparc, and x86 and
>> didn't see any issues related to this patch.  There might still be
>> something,  but I'm willing to help work through them or revert this
>> if it turns out to be a problem.  I'm still assuming that Grant will
>> handle this.
>>
>> Bjorn
> Hi Grant,
> 
> Is this patch ok with you ? If so would you mind if Ralf takes this via
> his tree ? (this would avoid merge order problems)
> 

This looks fine to me and merging thru Ralf's tree is fine.

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> Thanks,
> John
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
