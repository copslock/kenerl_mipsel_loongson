Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2004 00:39:48 +0000 (GMT)
Received: from [IPv6:::ffff:67.109.220.20] ([IPv6:::ffff:67.109.220.20]:46523
	"EHLO starbase.tos.net") by linux-mips.org with ESMTP
	id <S8225274AbUL1Ajn>; Tue, 28 Dec 2004 00:39:43 +0000
Received: from intrepid (c-67-175-6-30.client.comcast.net [67.175.6.30])
	(authenticated bits=0)
	by starbase.tos.net (8.13.1/8.13.1) with ESMTP id iBS0dFXA014161
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-mips@linux-mips.org>; Mon, 27 Dec 2004 18:39:16 -0600
Message-Id: <200412280039.iBS0dFXA014161@starbase.tos.net>
From: "Habeeb J. Dihu" <macgyver@tos.net>
To: <linux-mips@linux-mips.org>
Subject: RE: 2.6.9 Cobalt Tulip lockups.
Date: Mon, 27 Dec 2004 18:38:23 -0600
Keywords: Mailing List, linux-mips
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20041227233126.GA6680@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
thread-index: AcTsbGbjJgAekQEpQbqsruLYRcFWTAABDepw
X-Virus-Scanned: ClamAV 0.80/618/Sun Dec  5 17:09:24 2004
	clamav-milter version 0.80j
	on starbase.tos.net
X-Virus-Status: Clean
Return-Path: <macgyver@tos.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macgyver@tos.net
Precedence: bulk
X-list: linux-mips

Grrr...thought I did and ended up pasting the wrong output. :)  Here's the
decoded output:

Trace; 800b32c8 <local_bh_enable+b8/c0>
Trace; 80084e28 <do_IRQ+1d8/208>
Trace; 80397ee8 <svc_sock_enqueue+248/4d0>
Trace; 80397f08 <svc_sock_enqueue+268/4d0>
Trace; 80398af4 <svc_write_space+44/b0>
Trace; 8029a374 <sock_wfree+140/1d4>
Trace; 800b87ac <update_process_times+2c/54>
Trace; 800ad20c <profile_tick+40/48>
Trace; 8029ccbc <__kfree_skb+d0/430>
Trace; 802bc8b0 <zap_completion_queue+8c/d8>
Trace; 802bc918 <find_skb+1c/140>
Trace; 802bcba8 <netpoll_send_udp+3c/30c>
Trace; 802575bc <serial8250_console_write+a4/354>
Trace; 8027b370 <write_msg+70/b8>
Trace; 800abe34 <__call_console_drivers+8c/94>
Trace; 800abe34 <__call_console_drivers+8c/94>
Trace; 800b3168 <__do_softirq+108/11c>
Trace; 800abebc <_call_console_drivers+80/90>
Trace; 800abf80 <call_console_drivers+b4/170>
Trace; 800ac6b8 <release_console_sem+c8/288>
Trace; 8022e900 <vscnprintf+14/30>
Trace; 800ac34c <vprintk+1cc/32c>
Trace; 8022e900 <vscnprintf+14/30>
Trace; 800ac278 <vprintk+f8/32c>
Trace; 800ac174 <printk+1c/28>
Trace; 80279dec <t21142_timer+46c/474>
Trace; 80279980 <t21142_timer+0/474>
Trace; 800b8954 <run_timer_softirq+14c/2a8>
Trace; 802b9458 <nf_iterate+d4/118>
Trace; 800b3168 <__do_softirq+108/11c>
Trace; 80084808 <handle_IRQ_event+6c/f0>
Trace; 800b3208 <do_softirq+8c/94>
Trace; 80084e18 <do_IRQ+1c8/208>
Trace; 80082908 <cobalt_irq+68/180>
Trace; 802dc1bc <ip_finish_output2+0/5b4>
Trace; 80083180 <ret_from_exception+0/0>
Trace; 802d89d8 <ip_output+78/94>
Trace; 8030ffdc <inet_sendmsg+60/84>
Trace; 80303260 <udp_sendmsg+374/a74>
Trace; 802da298 <ip_generic_getfrag+0/bc>
Trace; 80084e28 <do_IRQ+1d8/208>
Trace; 8029afb0 <sock_alloc_send_pskb+208/56c>
Trace; 8029b330 <sock_alloc_send_skb+1c/28>
Trace; 80138718 <iput+4c/a8>
Trace; 802dad80 <ip_append_data+a2c/b1c>
Trace; 80134538 <d_alloc_anon+30/1a4>
Trace; 800a4198 <try_to_wake_up+140/1b0>
Trace; 802d07c0 <ip_route_output_flow+88/ac>
Trace; 803031ec <udp_sendmsg+300/a74>
Trace; 8030ffdc <inet_sendmsg+60/84>
Trace; 80214364 <selinux_socket_sendmsg+1c/28>
Trace; 80295864 <sock_sendmsg+10c/114>
Trace; 800a7440 <autoremove_wake_function+0/44>
Trace; 8030ffdc <inet_sendmsg+60/84>
Trace; 80214364 <selinux_socket_sendmsg+1c/28>
Trace; 80295894 <kernel_sendmsg+28/3c>
Trace; 80295864 <sock_sendmsg+10c/114>
Trace; 8029b7b4 <sock_no_sendpage+68/74>
Trace; 80303ab8 <udp_sendpage+158/194>
Trace; 80303aa0 <udp_sendpage+140/194>
Trace; 8020e0d4 <file_alloc_security+2c/a0>
Trace; 800a7440 <autoremove_wake_function+0/44>
Trace; 802120f4 <selinux_inode_getattr+70/7c>
Trace; 800a40c8 <try_to_wake_up+70/1b0>
Trace; 80310070 <inet_sendpage+70/d0>
Trace; 80398698 <svc_sendto+8c/244>
Trace; 80398840 <svc_sendto+234/244>
Trace; 8029ca50 <skb_release_data+118/280>
Trace; 801d6f8c <nfssvc_encode_attrstat+37c/5a0>
Trace; 8029cd50 <__kfree_skb+164/430>
Trace; 8039918c <svc_udp_sendto+20/5c>
Trace; 801cab18 <fh_put+18c/288>
Trace; 8039b554 <svc_send+210/2ec>
Trace; 8039c8a4 <svc_authorise+30/170>
Trace; 801d8068 <nfssvc_release_fhandle+10/28>
Trace; 80397740 <svc_process+334/894>
Trace; 800bdbe8 <sigprocmask+98/1ec>
Trace; 801c7398 <nfsd+2cc/6b8>
Trace; 801c7274 <nfsd+1a8/6b8>
Trace; 801c70cc <nfsd+0/6b8>
Trace; 80086070 <kernel_thread_helper+10/18>
Trace; 80086060 <kernel_thread_helper+0/18>
 

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
Sent: Monday, December 27, 2004 5:31 PM
To: Habeeb J. Dihu
Cc: linux-mips@linux-mips.org
Subject: Re: 2.6.9 Cobalt Tulip lockups.

On Mon, Dec 27, 2004 at 05:12:50PM -0600, Habeeb J. Dihu wrote:

> eth0: MII status 782d, Link partner report 45e1.
> eth0: 21143 negotiation status 000000c6, MII.
> Badness in local_bh_enable at kernel/softirq.c:141
> Call Trace: [<800b32c8>]  [<80084e28>]  [<80397ee8>]  [<80397f08>]
> [<80398af4>]  [<8029a374>]  [<800b87ac>]  [<800ad20c>]  [<8029ccbc>]
> [<802bc8b0>]  [<802bc918>]  [<802bcba8>]  [<802575bc>]  [<8027b370>]
> [<800abe34>]  [<800abe34>]  [<800b3168>]  [<800abebc>]  [<800abf80>]
> [<800ac6b8>]  [<8022e900>]  [<800ac34c>]  [<8022e900>]  [<800ac278>]
> [<800ac174>]  [<80279dec>]  [<80279980>]  [<800b8954>]  [<802b9458>]
> [<800b3168>]  [<80084808>]  [<800b3208>]  [<80084e18>]  [<80082908>]
> [<802dc1bc>]  [<80083180>]  [<802d89d8>]  [<8030ffdc>]  [<80303260>]
> [<802da298>]  [<80084e28>]  [<8029afb0>]  [<8029b330>]  [<80138718>]
> [<802dad80>]  [<80134538>]  [<800a4198>]  [<802d07c0>]  [<803031ec>]
> [<8030ffdc>]  [<80214364>]  [<80295864>]  [<800a7440>]  [<8030ffdc>]
> [<80214364>]  [<80295894>]  [<80295864>]  [<8029b7b4>]  [<80303ab8>]
> [<80303aa0>]  [<8020e0d4>]  [<800a7440>]  [<802120f4>]  [<800a40c8>]
> [<80310070>]  [<80398698>]  [<80398840>]  [<8029ca50>]  [<801d6f8c>]
> [<8029cd50>]  [<8039918c>]  [<801cab18>]  [<8039b554>]  [<8039c8a4>]
> [<801d8068>]  [<80397740>]  [<800bdbe8>]  [<801c7398>]  [<801c7274>]
> [<801c70cc>]  [<80086070>]  [<80086060>] 

Can you decode this dump?  Undecoded it's useless, decoded likely to
be useful ...

  Ralf
