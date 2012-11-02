Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 19:38:48 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48643 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6823039Ab2KBSipn9hJX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Nov 2012 19:38:45 +0100
Received: from 210.34.21.95.dynamic.jazztel.es ([95.21.34.210] helo=mail.viric.name)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1TUM8a-0007yD-9q
        for linux-mips@linux-mips.org; Fri, 02 Nov 2012 18:38:37 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 776522D5B39; Fri,  2 Nov 2012 19:38:29 +0100 (CET)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 95.21.34.210
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX193Dr4zgDxPWiw++ELvvpbn
Date:   Fri, 2 Nov 2012 19:38:28 +0100
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     linux-mips@linux-mips.org
Subject: Failing INOTIFY in 3.6.x?
Message-ID: <20121102183828.GX2052@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 8BIT
X-archive-position: 34861
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

updating my kernel from 3.4.2 to 3.6.4, I've noticed that upstart deadlocks at
the very start. Stracing, I think it has to do with INOTIFY, because it
deadlocks very early and little more has been done then.

Going 'back' to 3.4.16, makes upstart work fine. I've not tested middle kernels.

I've seen this only on the fuloong minipc (mips n64), but I've done similar
steps with the same distributions on armv5tel, i686 and x86_64, and there all
works fine.

Does anybody know of anything broken around inotify, between 3.4 and 3.6 linux
mips?

Any suggestion on what kernel change could have related to this, and so, get a
clue about what middle version to test?

Regards,
Lluís.
