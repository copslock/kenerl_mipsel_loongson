Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Oct 2002 14:05:20 +0200 (CEST)
Received: from ppp-104.net10.magic.fr ([195.154.128.104]:10769 "HELO
	volvic.sud.stepmind.com") by linux-mips.org with SMTP
	id <S1123916AbSJVMFT>; Tue, 22 Oct 2002 14:05:19 +0200
Received: (qmail 8815 invoked from network); 22 Oct 2002 11:56:58 -0000
Received: from eku.sud.stepmind.com (HELO stepmind.com) (192.168.1.103)
  by volvic.sud.stepmind.com with SMTP; 22 Oct 2002 11:56:58 -0000
Message-ID: <3DB53D09.9010503@stepmind.com>
Date: Tue, 22 Oct 2002 13:56:57 +0200
From: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@stepmind.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021021
X-Accept-Language: fr, en, de
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: {swapper:1] illegal instruction at ...
References: <20021022114557.26269.qmail@webmail22.rediffmail.com>
In-Reply-To: <20021022114557.26269.qmail@webmail22.rediffmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <vincent.stehle@stepmind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vincent.stehle@stepmind.com
Precedence: bulk
X-list: linux-mips

atul srivastava wrote:
> I have just now enabled the nfs mount of root file system.
> after this when I boot i get so many repeated messages like..
> 
> [swapper:1] Illegal instruction d0c62bd0 at 800f7c6c ra=
> 800f4860
> [swapper:1] Illegal instruction 0031c78 at 800f5b5c at ra=8002d954
[..]
> can somebody suggest me something..

As it seems your problem has something to do with the swapper, are you 
also trying to swap over nfs ? I think you need patches for that:

   http://www.instmath.rwth-aachen.de/~heine/nfs-swap/nfs-swap.html

-- 
  Vincent Stehlé
