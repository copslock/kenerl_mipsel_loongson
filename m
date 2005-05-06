Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 16:46:58 +0100 (BST)
Received: from smtp002.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.126]:45978
	"HELO smtp002.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226007AbVEFPqn>; Fri, 6 May 2005 16:46:43 +0100
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp002.bizmail.yahoo.com with SMTP; 6 May 2005 15:46:39 -0000
Subject: Re: dbau1200 ethernet driver?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <261758805.20050506155322@izmiran.rssi.ru>
References: <261758805.20050506155322@izmiran.rssi.ru>
Content-Type: text/plain; charset=utf-8
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 06 May 2005 08:46:40 -0700
Message-Id: <1115394400.5785.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-05-06 at 15:53 +0300, Ruslan V.Pisarev wrote:
>   Hi!
> 
>  I compiled last 2.6 kernel (2-3 weeks ago from cvs@linux-mips) and
> trying to start it on DBAu1200 development board. First problem I
> discovered with "nfsroot" configuration - is that kernel cannot find
> network interface at boot-time.
>  There is a smc91c111 network chip on board, so my question is - what
> driver is suitable with him?

The smc91x.c driver. However, I don't remember if that driver was
tested.  The board was tested with a different smc driver which I
couldn't push in the tree because it was old and would conflict with the
smc91x.c.

>  Is it "MIPS AU1000 Ethernet support"
> which fails to compile with "error: `NUM_ETH_INTERFACES' undeclared"
> (and it must be?) or something different? It seems that I have enabled
> all other options for ethernet functionality.

Well, that's a different driver.



Pete

> 
> 
> the part of boot log is:
> 
> loop: loaded (max 8 devices)
> nbd: registered device at major 43
> NET: Registered protocol family 2
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> IP-Config: No network devices available.
> Looking up port of RPC 100003/2 on 192.168.0.30
> RPC: sendmsg returned error 128
> portmap: RPC call returned error 128
> Root-NFS: Unable to get nfsd port number from server, using default
> Looking up port of RPC 100005/1 on 192.168.0.30
> RPC: sendmsg returned error 128
> portmap: RPC call returned error 128
> Root-NFS: Unable to get mountd port number from server, using default
> RPC: sendmsg returned error 128
> mount: RPC call returned error 128
> 
> 
>    ()_()
> --( °,° )---[21398845]-[jerry¤wicomtechnologies.com]-
>   (") (")                 -<The Bat! 3.0.1.33>- -<06/05/2005 15:35>-
> 
> 
