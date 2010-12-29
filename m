Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 14:06:03 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:39653 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0L2NF7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Dec 2010 14:05:59 +0100
Received: by ewy20 with SMTP id 20so4489613ewy.36
        for <multiple recipients>; Wed, 29 Dec 2010 05:05:57 -0800 (PST)
Received: by 10.213.9.204 with SMTP id m12mr12918453ebm.68.1293627957334;
        Wed, 29 Dec 2010 05:05:57 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id b52sm10542776eei.13.2010.12.29.05.05.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 05:05:56 -0800 (PST)
Message-ID: <4D1B31E5.7010901@mvista.com>
Date:   Wed, 29 Dec 2010 16:04:37 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@redhat.com>
Subject: Re: [PATCH v4] jump lable: Add MIPS support.
References: <1293571583-14472-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1293571583-14472-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> In order not to be left behind, we add jump label support for MIPS.

    Just fix your subject, it has "lable".

> Tested on 64-bit big endian (Octeon), and 32-bit little endian
> (malta/qemu).

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jason Baron <jbaron@redhat.com>

WBR, Sergei
