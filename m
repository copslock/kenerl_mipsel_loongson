Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2004 23:15:05 +0000 (GMT)
Received: from rrcs-sw-24-153-140-91.biz.rr.com ([IPv6:::ffff:24.153.140.91]:19072
	"EHLO public.nshore.com") by linux-mips.org with ESMTP
	id <S8225578AbUBIXPE>; Mon, 9 Feb 2004 23:15:04 +0000
Received: from nshore.com (gate.nshore.com [192.168.1.2])
	by public.nshore.com (8.11.6/8.11.6) with ESMTP id i19NEGc02948;
	Mon, 9 Feb 2004 17:14:17 -0600
Message-ID: <40281470.1000701@nshore.com>
Date: Mon, 09 Feb 2004 17:14:56 -0600
From: Tahoma Toelkes <tahoma@nshore.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007 MultiZilla/1.6.0.0e
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
CC: linux-mips@linux-mips.org
Subject: Re: difficulties with NFSROOT and DHCP
References: <4027F08D.5030601@nshore.com> <20040210064821.7ef6a72f.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20040210064821.7ef6a72f.yuasa@hh.iij4u.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tahoma@nshore.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tahoma@nshore.com
Precedence: bulk
X-list: linux-mips

Yes!  That was the trick.  I've now booted and am able to ping the 
board.  Thank you, thank you, thank you.

If you're ever in Austin, Yoichi, you should let me treat you to a 
pitcher of beer (or a bottle of wine/sake...whatever).  :-)

Thanks again,
-- Tahoma


Yoichi Yuasa wrote:

>Hi,
>
>On Mon, 09 Feb 2004 14:41:49 -0600
>Tahoma Toelkes <tahoma@nshore.com> wrote:
>
>  
>
>>The context is that I am in the process of bringing up a 2.4.24 kernel 
>>(pulled from linux-mips CVS using the linux_2_4_24 tag) on a DBAu1500 
>>board (Zinfandel).
>>
>>I'm having trouble mounting my root filesystem over NFS.  After the 
>>ethernet ports have been enumerated, the kernel attempts to contact the 
>>DHCP server to obtain its IP configuration information.  At this point 
>>the boot sequence hangs, perpetually retrying the DHCP server.  Here are 
>>the last several lines from the log of the boot messages, prefixed with 
>>a vertical bar to set them apart:
>>
>>| Sending DHCP requests .<6>eth0: link up
>>| eth0: going to full duplex
>>| ..... timed out!
>>| IP-Config: Retrying forever (NFS root)...
>>| Sending DHCP requests ...... timed out!
>>| IP-Config: Retrying forever (NFS root)...
>>| Sending DHCP requests ..
>>
>>I've verified that the exported root filesystem can be mounted by 
>>another Linux workstation.  I've also verified on the DHCP server that 
>>it is seeing the board initiate a DHCP discovery and that the DHCP 
>>server is replying with offer for the correct address.  Here is an 
>>excerpt from '/var/log/messages' on the DHCP server:
>>
>>| Feb  9 13:25:33 kapala dhcpd: DHCPDISCOVER from 00:50:c2:0c:38:8a via eth0
>>| Feb  9 13:25:33 kapala dhcpd: DHCPOFFER on 172.16.108.42 to 
>>00:50:c2:0c:38:8a via eth0
>>    
>>
>
>Please try the following option.
>
>YAMON> go . root=/dev/nfs nfsroot=172.16.108.11:/export/root ip=dhcp
>
>
>  
>
>>For completeness sake, I've attached the full log of the boot sequence 
>>until it hangs as well as my current kernel configuration.  If any of 
>>you have seen this particular problem and know how to get around it, 
>>please respond.  Further, if you simply have suggestions for avenues I 
>>could explore, I would appreciate any advice you might have to offer.
>>    
>>
>
>Yoichi
>  
>
