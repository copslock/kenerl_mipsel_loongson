Received:  by oss.sgi.com id <S553735AbQK2AOh>;
	Tue, 28 Nov 2000 16:14:37 -0800
Received: from NS.CenSoft.COM ([208.219.23.2]:61199 "EHLO
        ns.centurysoftware.com") by oss.sgi.com with ESMTP
	id <S553716AbQK2AOM>; Tue, 28 Nov 2000 16:14:12 -0800
Received: from censoft.com (IDENT:jordanc@cen94.censoft.com [208.219.23.94])
	by ns.centurysoftware.com (8.9.3/8.9.3) with ESMTP id SAA06943
	for <linux-mips@oss.sgi.com>; Tue, 28 Nov 2000 18:28:31 -0700 (MST)
Message-ID: <3A244A2C.5C648B27@censoft.com>
Date:   Tue, 28 Nov 2000 17:13:32 -0700
From:   Jordan Crouse <jordanc@Censoft.com>
Organization: Century Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: DNS 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Has anyone encountered peculiar happenings with the 2.0.7 glibc and
resolving names via DNS?  It is simply *NOT* going out to the specifiec
nameserver (verified via line sniffer), even though /etc/resolv.conf is
present and correct.  Any lookups with the /etc/hosts file work great,
its just when I try to go out on the network.

Has anyone noticed any strangeness with this????

Jordan
