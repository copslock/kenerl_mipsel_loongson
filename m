Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3AFdTJ07827
	for linux-mips-outgoing; Tue, 10 Apr 2001 08:39:29 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3AFdSM07824
	for <linux-mips@oss.sgi.com>; Tue, 10 Apr 2001 08:39:28 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id KAA22659
	for <linux-mips@oss.sgi.com>; Tue, 10 Apr 2001 10:39:26 -0500
Message-ID: <3AD337DA.16570750@cotw.com>
Date: Tue, 10 Apr 2001 09:42:02 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: loadaddr
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When I linked using a 2.4.0 kernel

head System.map
0000000000000000 A usbdevfs_cleanup
0000000080001000 T _ftext
0000000080002288 T except_vec0_r4000
00000000800022f0 T except_vec0_r4600
0000000080002344 T except_vec0_nevada
000000008000239c T except_vec0_r45k_bvahwbug
00000000800023fc T except_vec0_r4k_250MHZhwbug
0000000080002458 T except_vec0_r2300
000000008000249c T except_vec1_generic
00000000800024dc T except_vec2_generic


When I link a 2.4.2 kernlel
head System.map
000000000000002c A usbdevfs_cleanup
ffffffff80002000 T _ftext
ffffffff80002288 T except_vec0_r4000
ffffffff800022f0 T except_vec0_r4600
ffffffff80002344 T except_vec0_nevada
ffffffff8000239c T except_vec0_r45k_bvahwbug
ffffffff800023fc T except_vec0_r4k_250MHZhwbug
ffffffff80002458 T except_vec0_r2300
ffffffff8000249c T except_vec1_generic
ffffffff800024dc T except_vec2_generic

----------------------------------

What am I doing that is causing the  leading ffffffff in the addresses?

Thanks,
Scott
