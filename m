Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 16:36:37 +0100 (BST)
Received: from walscop001.walsimou.com ([82.228.201.70]:26074 "EHLO
	bekkor.walsimou.com") by ftp.linux-mips.org with ESMTP
	id S28582530AbYHTPga (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 16:36:30 +0100
Received: from ziontrain.innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
  (AUTH: LOGIN walsimou@walsimou.com, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by bekkor.walsimou.com with esmtp; Wed, 20 Aug 2008 17:31:07 +0200
  id 01093D21.48AC38BB.00016C77
Message-ID: <48AC39D2.3050905@walsimou.com>
Date:	Wed, 20 Aug 2008 17:35:46 +0200
From:	Gaye Abdoulaye Walsimou <walsimou@walsimou.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	mikeci@acm.org
CC:	linux-mips@linux-mips.org
Subject: Re: Question about using initramfs
References: <48AC2EEE.5020008@dslextreme.com>
In-Reply-To: <48AC2EEE.5020008@dslextreme.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <walsimou@walsimou.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walsimou@walsimou.com
Precedence: bulk
X-list: linux-mips

Ivica Mikec a écrit :
> Hi,
>
> I am trying to use initramfs on MIPS 24kc. Is there a size limit on 
> memory used by initramfs?
>
> Thanks.
In the kernel configuration, under block devices, you can define ramdisk 
size, may it's what you are looking for...
regards
