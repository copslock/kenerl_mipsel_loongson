Received:  by oss.sgi.com id <S553773AbQJYARR>;
	Tue, 24 Oct 2000 17:17:17 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:44537 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553665AbQJYAQ5>;
	Tue, 24 Oct 2000 17:16:57 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9P0FL304777;
	Tue, 24 Oct 2000 17:15:21 -0700
Message-ID: <39F626C9.96146652@mvista.com>
Date:   Tue, 24 Oct 2000 17:18:17 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: gcc : ... is greater than maximum object file alignment
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I looked carefully again at the output for building glibc, and I found
the following warnings.  If I remembered correctly, Ralf has already
fixed a similar problem a while back.  Maybe it is not in the patch
file?  I am using egcs-1.0.3a-2.diff.gz on oss.sgi.com site.

pthread.c:31: warning: alignment of `__pthread_initial_thread' is
greater than maximum object file alignment
pthread.c:62: warning: alignment of `__pthread_manager_thread' is
greater than maximum object file alignment


Jun
