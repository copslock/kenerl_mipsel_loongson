Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 13:34:58 +0100 (BST)
Received: from dsl-KK-static-026.199.95.61.airtelbroadband.in ([61.95.199.26]:28110
	"EHLO mailsvr.procsyc.com") by ftp.linux-mips.org with ESMTP
	id S20026876AbXHHMe4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 13:34:56 +0100
Received: from [127.0.0.1] ([192.168.1.243])
	by mailsvr.procsyc.com (8.13.5/8.13.5) with ESMTP id l78CSbWU006778;
	Wed, 8 Aug 2007 17:58:40 +0530
Message-ID: <46B9B6B1.3000704@procsys.com>
Date:	Wed, 08 Aug 2007 17:57:29 +0530
From:	ankur maheshwari <ankur_maheshwari@procsys.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To:	bamakhrama@gmail.com
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Problems with NFS boot
References: <40378e40708080318w7dc0f0b7s4c94c98acd72ec2c@mail.gmail.com>	 <20070808103119.GB5622@linux-mips.org> <40378e40708080431h56f18f0bjb24d1cc60ed92de1@mail.gmail.com>
In-Reply-To: <40378e40708080431h56f18f0bjb24d1cc60ed92de1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.91/3892/Wed Aug  8 15:35:19 2007 on mailsvr.procsyc.com
X-Virus-Status:	Clean
Return-Path: <ankur_maheshwari@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ankur_maheshwari@procsys.com
Precedence: bulk
X-list: linux-mips

Please try similar to this working example; I use it successfully in my 
case.

setenv bootargs root=/dev/nfs rw nfsroot=192.168.1.10:/opt/target 
ip=192.168.1.11:192.168.1.5:192.168.1.10:255.255.255.0:::off


If booting from u-boot I use this following
root=/dev/nfs rw nfsroot=\\$(serverip):/opt/target 
ip=\\$(ipaddr):\\$(serverip):\\$(gatewayip):\\$(netmask):\\$(hostname)::off


thanks
Ankur  



Mohamed Bamakhrama wrote:
> Hi Ralf,
> I added the ":" at the end. It is still not working. I get the same error:
>
> VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
> Please append a correct "root=" boot option; here are the available partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>
> Do I have to set any special config. info in the the kernel config
> beside the NFS support?
>
>
>
> On 8/8/07, Ralf Baechle <ralf@linux-mips.org> wrote:
>   
>> On Wed, Aug 08, 2007 at 12:18:51PM +0200, Mohamed Bamakhrama wrote:
>>
>>     
>>> Hi list,
>>> I have a Malta board for which I was able to build the kernel, load it
>>> and start it. The problem comes when it tries to boot through the NFS.
>>>
>>> I start the kernel with the following command:
>>> go . nfsroot=192.168.1.1/mnt/danube_rootfs ip=192.168.1.4:192.168.1.1:::
>>>       
>>                         ^^ there should be a `:' following the IP.
>>
>>  Ralf
>>
>>     
>
>
>   
