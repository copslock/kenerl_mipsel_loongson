Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 15:48:26 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37904 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010189AbbETNsYtFZo1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 May 2015 15:48:24 +0200
Received: by igcau1 with SMTP id au1so39892704igc.1;
        Wed, 20 May 2015 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sVIs+Tqd9IMHtfexUxcm6AzPc72IDom/aO0cmtjiIkg=;
        b=ZbfEaDJSHI3zc6P4JLwMlAX/6iRFw3H2VbN5wZ7HAfjr7AbA1GheULAiFWmpr7S0ge
         1rTLhibgt4HZx14x8GJ3s8OXkgHXg6kK+nW14GZyB6QXID/29tCoM4y9iiq36U4cON8y
         RCDt5Xzwswv59KW6v0DSH6hesfN5IO33UidHYXfMfhdTKvBfQREl/NySJk0pWULJR8nA
         HKyCPCuCtstPUvJQjgjrMpa3fY2oALTI/bohLAhjgie/X4Rlxrwl9g2Eg6b8902qlKwb
         Zt3g48OwGqZlTrc69dWuK/OCTQyklV/iXnMWdsCjQ9UWik4+VnPjkXe8lW34aRLnwHE7
         vueQ==
MIME-Version: 1.0
X-Received: by 10.42.85.147 with SMTP id q19mr5492524icl.96.1432129701335;
 Wed, 20 May 2015 06:48:21 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Wed, 20 May 2015 06:48:21 -0700 (PDT)
In-Reply-To: <555C83FC.7010701@broadcom.com>
References: <1432122655-3224-1-git-send-email-arend@broadcom.com>
        <CACna6rxeU0FUiTRNXFgK-xxSDY8WA82h7MLmcPc=7eM5sqMdBw@mail.gmail.com>
        <555C83FC.7010701@broadcom.com>
Date:   Wed, 20 May 2015 15:48:21 +0200
Message-ID: <CACna6rw3ZgJSLrR=kNKDNgcLHz7-bZjaObv2zuTgmWWeUtLSUw@mail.gmail.com>
Subject: Re: [PATCH RESEND] mips: bcm47xx: allow retrieval of complete nvram contents
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 20 May 2015 at 14:54, Arend van Spriel <arend@broadcom.com> wrote:
> On 05/20/15 14:31, Rafał Miłecki wrote:
>>
>> On 20 May 2015 at 13:50, Arend van Spriel<arend@broadcom.com>  wrote:
>>>
>>> From: Hante Meuleman<meuleman@broadcom.com>
>>>
>>> Host platforms such as routers supported by OpenWRT can
>>> support NVRAM reading directly from internal NVRAM store.
>>> The brcmfmac for one requires the complete nvram contents
>>> to select what needs to be sent to wireless device.
>>
>>
>> First of all, I have to ask you to rebase this patch on top of
>> upstream-sfr. Mostly because of
>> MIPS: BCM47XX: Make sure NVRAM buffer ends with \0
>
>
> No idea what upstream-sfr is. I applied the patch on top of the master
> branch of linux-mips repo [1]. What am I missing here?
>
> [1] http://git.linux-mips.org/cgit/ralf/linux.git

Just go a dir higher and you'll find it :)
http://git.linux-mips.org/cgit/

Its a repo with mips-for-linux-next branch you're looking for.
