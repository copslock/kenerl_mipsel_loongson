Received:  by oss.sgi.com id <S42258AbQJJTbQ>;
	Tue, 10 Oct 2000 12:31:16 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:45565 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42250AbQJJTbA>;
	Tue, 10 Oct 2000 12:31:00 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9AJTHx28981;
	Tue, 10 Oct 2000 12:29:17 -0700
Message-ID: <39E3D0B8.7F221344@mvista.com>
Date:   Tue, 10 Oct 2000 19:30:16 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        debian-mips@lists.debian.org
Subject: glibc on MIPS ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Does anybody what is the status of glibc on MIPS?

So far I have been using the glibc coming from linux-vr project.  It is
v2.0.7.  Somehow the pthread does not appear to be working. 
pthread_create() returns EAGIN error, even though clone() system returns
correct result.

I looked at the cvs tree on oss.sgi.com.  The glibc version is 2.0.6. 
What is the status of this version?

I also heard about the debian-mips project.  What glibc is used here?

Thanks.

Jun
