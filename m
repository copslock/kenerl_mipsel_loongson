Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 20:10:49 +0100 (CET)
Received: from mail177-1.suw61.mandrillapp.com ([198.2.177.1]:23001 "EHLO
        mail177-1.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007550AbcCATKruanoh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 20:10:47 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=mandrill; d=linuxfoundation.org;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=gregkh@linuxfoundation.org;
 bh=c/uKRq1Lj0pHHQUs/hQNlAEOm8g=;
 b=fWNxXOqAAJ0fqwqbhunwzfVavzJKp4OUlI9Rk3v4RcAt1lIkifurnx5HAK4oLQPhmzJtphH6smmo
   cYfiM/KhJZbJSGvBacuthyMVfGVTQkEr0qUdVbucjoMTkLPu8Z/PgTGEqXsfChZSkZMlB+4Fqh2J
   d+SlO6+RW9O/oxcSikE=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-1.suw61.mandrillapp.com id hqnkje22rtk7 for <linux-mips@linux-mips.org>; Tue, 1 Mar 2016 19:10:44 +0000 (envelope-from <bounce-md_30481620.56d5e934.v1-b8c94b4daff54c9c8932d8518a06b2a3@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1456859444; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=9lE1y/nyGIIqDyOSUvYUNIHGsa+c4QATUVmvHmWh6mU=; 
 b=Rir1PZzxMcrC8djkDLILsUK6YvryjZlm/HgYCtr2XGeNYBVCnJL73k1/4JJpz4lOPJfXEg
 zVdQzDpkjx9V/BHRPJ7+IqZoGE4vI9gHKe6kNjgwdV6VYudVZi/pbCrp5M5qmLFGqootGdWt
 cOiShM4tmny/bqhr607BTQzs2B5fQ=
From:   <gregkh@linuxfoundation.org>
Subject: Patch "Revert "MIPS: Fix PAGE_MASK definition"" has been added to the 4.4-stable tree
Received: from [50.170.35.168] by mandrillapp.com id b8c94b4daff54c9c8932d8518a06b2a3; Tue, 01 Mar 2016 19:10:44 +0000
To:     <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <linux-mips@linux-mips.org>, <manuel.lauss@gmail.com>,
        <ralf@linux-mips.org>
Cc:     <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
Message-Id: <145685944232118@kroah.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=30481620.b8c94b4daff54c9c8932d8518a06b2a3
X-Mandrill-User: md_30481620
Date:   Tue, 01 Mar 2016 19:10:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bounce-md_30481620.56d5e934.v1-b8c94b4daff54c9c8932d8518a06b2a3@mandrillapp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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


This is a note to let you know that I've just added the patch titled

    Revert "MIPS: Fix PAGE_MASK definition"

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-mips-fix-page_mask-definition.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
