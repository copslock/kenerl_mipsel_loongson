Received:  by oss.sgi.com id <S553977AbRAJB7S>;
	Tue, 9 Jan 2001 17:59:18 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:33809 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553974AbRAJB66>;
	Tue, 9 Jan 2001 17:58:58 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id CEAAB205FC
	for <linux-mips@oss.sgi.com>; Tue,  9 Jan 2001 17:58:52 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Tue, 09 Jan 2001 17:53:31 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id 1ABC415961
	for <linux-mips@oss.sgi.com>; Tue,  9 Jan 2001 17:58:53 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 5A970686D; Tue,  9 Jan 2001 17:59:01 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     linux-mips@oss.sgi.com
Subject: _clear_page semantics
Date:   Tue, 9 Jan 2001 17:48:11 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01010917590106.07691@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Looking at the existing clear_page implementations for r4xx0, rm7k, and mips32
in the mips/ tree, I see everyone issuing cache op 0xd for the address range of
the page being cleared.

I'm wondering what the purpose is of these cache flushes...given a physically
tagged dcache, my understanding of the semantics of clear_page are that it just
zeros the page, in which case the cache ops are pointless overhead.

Especially in the mips32 case, which uses cache op 0xd, which is undefined
implementation dependent according to my mips32 spec.

Am I missing something here?

Thanks,
Justin
