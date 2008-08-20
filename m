Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 19:21:06 +0100 (BST)
Received: from mail5.dslextreme.com ([66.51.199.81]:43473 "HELO
	mail5.dslextreme.com") by ftp.linux-mips.org with SMTP
	id S28585611AbYHTSVB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 19:21:01 +0100
Received: (qmail 27398 invoked from network); 20 Aug 2008 18:19:27 -0000
Received: from unknown (HELO webmail.dslextreme.com) (mikeci@192.168.7.18)
	by mail5.dslextreme.com with SMTP; Wed, 20 Aug 2008 11:19:27 -0700
Message-ID: <1bd89af55ea11c1ca4092a.20080820111929.zvxrpv@webmail.dslextreme.com>
In-Reply-To: <48AC39D2.3050905@walsimou.com>
References: <48AC2EEE.5020008@dslextreme.com>
    <48AC39D2.3050905@walsimou.com>
Date:	Wed, 20 Aug 2008 11:19:29 -0700 (PDT)
Subject: Re: Question about using initramfs
From:	"Ivica Mikec" <mikeci@acm.org>
To:	"Gaye Abdoulaye Walsimou" <walsimou@walsimou.com>
Cc:	linux-mips@linux-mips.org
Reply-To: mikeci@acm.org
User-Agent: DSL Extreme Webmail (www.dslextreme.com)
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3
Importance: Normal
Return-Path: <mikeci@acm.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikeci@acm.org
Precedence: bulk
X-list: linux-mips

I don't think so. ramdisk size is for initrd and not for initramfs. Can
someone correct me if I am wrong?


Gaye Abdoulaye Walsimou
> Ivica Mikec a écrit :
>> Hi,
>>
>> I am trying to use initramfs on MIPS 24kc. Is there a size limit on
>> memory used by initramfs?
>>
>> Thanks.
> In the kernel configuration, under block devices, you can define ramdisk
> size, may it's what you are looking for...
> regards
>
