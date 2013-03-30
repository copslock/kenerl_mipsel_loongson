Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Mar 2013 00:29:58 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33342 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6823116Ab3C3X3zIwgBv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Mar 2013 00:29:55 +0100
Received: from 234.140.79.188.dynamic.jazztel.es ([188.79.140.234] helo=mail.viric.name)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1UM5DZ-000Ep8-0S
        for linux-mips@linux-mips.org; Sat, 30 Mar 2013 23:29:49 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 088AE43FE67F; Sat, 30 Mar 2013 23:29:44 +0000 (Europe)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 188.79.140.234
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19JQIrU6RHCg9QNzv4lv+KT
Date:   Sun, 31 Mar 2013 00:29:44 +0100
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     linux-mips@linux-mips.org
Subject: FTRACE makes the kernel not boot
Message-ID: <20130330232944.GR10445@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Transfer-Encoding: 8BIT
X-archive-position: 35997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viric@viric.name
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello,

For a fuloong (loongson2f) I had two configs, one booted and the other not, on
a linux 3.8. I narrowed down the difference to enabling CONFIG_FTRACE.

Enabling CONFIG_FTRACE makes the kernel not load at all; it even does not print
any early printk to the serial port.

Do you agree there is a problem with FTRACE? Maybe it is solved already
in the mips git branch?

Regards,
Lluís.
