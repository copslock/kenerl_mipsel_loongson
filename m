Received:  by oss.sgi.com id <S554257AbRASSNm>;
	Fri, 19 Jan 2001 10:13:42 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:55054 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S554252AbRASSNh>;
	Fri, 19 Jan 2001 10:13:37 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id BCDAB20601
	for <linux-mips@oss.sgi.com>; Fri, 19 Jan 2001 10:13:43 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 19 Jan 2001 10:07:56 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id A39A315967
	for <linux-mips@oss.sgi.com>; Fri, 19 Jan 2001 10:13:31 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id A0585686D; Fri, 19 Jan 2001 10:14:10 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     linux-mips@oss.sgi.com
Subject: R[45]KC PRiD fields?
Date:   Fri, 19 Jan 2001 10:11:23 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <0101191014100B.01043@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Does anyone happen to know what the R4Kc anc R5KC use for the company ID of the
PrID register (bits 23-16)?  I'm assuming it's 1, which is reserved for MTI,
but bits 15-8 seem to be carefully chosen not to conflict with previous
processors in the non-MIPS32/MIPS64 PRiD space. 

I'm trying to not break detection of those processors in cpu_probe()...

-Justin
