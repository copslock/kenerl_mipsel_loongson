Received:  by oss.sgi.com id <S553747AbRBQV1I>;
	Sat, 17 Feb 2001 13:27:08 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:60690 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553650AbRBQV0q>;
	Sat, 17 Feb 2001 13:26:46 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id F3E91205FB
	for <linux-mips@oss.sgi.com>; Sat, 17 Feb 2001 13:26:31 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Sat, 17 Feb 2001 13:20:15 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id B19D81595F
	for <linux-mips@oss.sgi.com>; Sat, 17 Feb 2001 13:26:31 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 8FE2B686D; Sat, 17 Feb 2001 13:27:16 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     linux-mips@oss.sgi.com
Subject: saved_command_line, arcs_cmdline, command_line
Date:   Sat, 17 Feb 2001 13:11:27 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <0102171327160R.15790@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I'm scanning over the command line arguments stuff, and noted a few things. 
Comments welcome.

Is there any reason saved_command_line is not architecture neutral?  Seems like
it should live in init/main.c, if anywhere.

Why do we have arcs_cmdline[] *AND* command_line[]?  Is there any respect in
which this isn't completely redundant?   (And misnamed, for that matter, for
non-arcs boards?)

-Justin
