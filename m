Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94FAFv13453
	for linux-mips-outgoing; Thu, 4 Oct 2001 08:10:15 -0700
Received: from firewall.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94FA8D13447
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 08:10:10 -0700
From: tommy.christensen@eicon.com
Received: (qmail 3425 invoked from network); 4 Oct 2001 15:10:06 -0000
Received: from idahub2000.i-data.com (HELO idanshub.i-data.com) (172.16.1.8)
  by firewall.i-data.com with SMTP; 4 Oct 2001 15:10:06 -0000
Received: from eicon.com ([172.17.159.1])          by idanshub.i-data.com (Lotus
 Domino Release 5.0.8)          with ESMTP id 2001100417122646:6498
 ;          Thu, 4 Oct 2001 17:12:26 +0200
Message-ID: <3BBC7C31.A452AD03@eicon.com>
Date: Thu, 4 Oct 2001 17:11:45 +0200
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Register allocation in copy_to_user
References: <3BB0D217.80E313F5@eicon.com>
X-MIMETrack: Itemize by SMTP Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 04-10-2001 17:12:26,
	MIME-CD by Notes Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 04-10-2001 17:12:26,
	MIME-CD complete at 04-10-2001 17:12:26,
	Serialize by Router on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at 04-10-2001
 17:12:27
Content-type: multipart/mixed; 
	Boundary="0__=C1256ADB0053896B8f9e8a93df938690918cC1256ADB0053896B"
Content-Disposition: inline
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

--0__=C1256ADB0053896B8f9e8a93df938690918cC1256ADB0053896B
Content-type: text/plain; charset=us-ascii


tommy.christensen@eicon.com wrote:
>
> Anyway, the attached patch solves this by explicitly building the
arguments
> to __copy_user in the argument registers ;-) instead of moving them
around.

This idea totally breaks, when the arguments (to copy_to_user) contain a
function call. We force the compiler to use a caller-saved register (like
a0)
across the function call. One place this happens is in net/ipv4/netfilter/
ip_tables.c/copy_entries_to_user().

The patch below fixes this, while preserving the original fix (for the tty
corruption). Although this is getting a little messy, the patch is not as
bad as it might seem. gcc will discard the extra temporary variables
(cu_to,
cu_from and cu_len) in far the most cases, and use them where necessary to
handle function calls.
Sorry, if this has caused any trouble.

-Tommy
(See attached file: uaccess.patch.gz)
--0__=C1256ADB0053896B8f9e8a93df938690918cC1256ADB0053896B
Content-type: application/octet-stream; 
	name="uaccess.patch.gz"
Content-Disposition: attachment; filename="uaccess.patch.gz"
Content-transfer-encoding: base64

H4sICDBjvDsAA3VhY2Nlc3MucGF0Y2gA7ZVda9swFIav419x8HZhz3Zqy2maugxSaAodHYWsWxkE
RLCVVMyRgiyXfbD/PlmyGydNXXbvK8lH5z3nPeJBDoIAKEvzMiMny2ITbOi2OCmXaUqKYvg45IKu
Bw8kgy9kC2gM4SSJUYLOAYVhZHme1yEe3D+WcJdKgBFEUYImCUJGN51CgM5CP4rB0+sYplMLyE9J
BIOC/iZYAsYp3/7CZUGE88RpBh8wltyHlLNCQhNZCb7xdxLmXlhgwbuMrCgjTQ3JTRkl1/nMBecP
LKxgIMiaFqrrc720VNlKp8bBGBz7/ch2L/ZT9w0oQVWzLTl9Ick5W4POzQlrp45NqndoRNvwuwx5
xw3Vdvxua96BNWPM77IIg2qixs9HUJdZT7lrpKLV2o5XxVSY1W0P1TryQqujB8pdZ722grW83rUO
TAWzMSM0Y2H8xPOlpDnB2NEn6ujz3dXX2xn+dHnrtNhz9XECtidscGoXrt/+1r73IqphpdOcT8aG
88l5w/lf9wijVZGe0p7SbkrtYUHkQjIuCBcZEQu2kPbbAFcgxuGZBjGO4uMg9k9lD+EOQroCx/zJ
Mf/hfJvNb66/44f5zf2snr269OfHzm0YfJXct/lEp4bPeNTBZ/9M9oR2ETqfXV7Vo5ur+x9EX3td
/wGM8rEbJQsAAA==

--0__=C1256ADB0053896B8f9e8a93df938690918cC1256ADB0053896B--
