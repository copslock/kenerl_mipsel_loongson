Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 08:57:28 +0100 (CET)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34016 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007196AbbCYH50h7pqI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 08:57:26 +0100
Received: by wgs2 with SMTP id 2so17550262wgs.1;
        Wed, 25 Mar 2015 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=tN6U81ERZD6dpSRkLubRdon18P/8VN4q5pIwkSlPm2M=;
        b=mgAtRUpC06htXG9bgtfpPy1fqOjwmMeMSo+LAerjkRs73QmMKu7sB8kFaIpmjOaWLm
         l4DUM6QuCQQRwccv8K5RI6vwgAoz0itS6pNFBa6OIvYL5/T/Nhi4JNilBYGin4kMwFlF
         ctloWlzPHZAKKQnfT9V/IgiQbq3aXgDNQquMoySN8rqPkiloFGK+kScv3CMqOa8A2D2X
         6hSJVwtbNB6hCdH3VEUMwedXU1/WpcWJvlD7lzM2XZ7GqsFKLO6zsiT0qjvkzhCYKw9x
         CEBodvYE4Y5XU70Gb9gFm4jHRa4Juw3e9MSDs0JMTO6aHB+DYiaC/aYqT4KcexeViPig
         bAhA==
X-Received: by 10.180.240.172 with SMTP id wb12mr13002094wic.55.1427270242346;
        Wed, 25 Mar 2015 00:57:22 -0700 (PDT)
Received: from station.rsr.lip6.fr (hp-valentin.rsr.lip6.fr. [132.227.64.74])
        by mx.google.com with ESMTPSA id y14sm2376293wjr.39.2015.03.25.00.57.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 00:57:21 -0700 (PDT)
Date:   Wed, 25 Mar 2015 08:57:20 +0100
From:   Valentin Rothberg <valentinrothberg@gmail.com>
To:     david.daney@cavium.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, lrosenboim@caviumnetworks.com,
        aleksey.makarov@auriga.com
Subject: Enable little endian kernel: misspelled Kconfig item
Message-ID: <20150325075720.GA18552@station.rsr.lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: valentinrothberg@gmail.com
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

Hi David,

your commit 9861908f081f ("MIPS: OCTEON: Enable little endian kernel.")
adds the following conditional select to arch/mips/Kconfig:

+       select SYS_SUPPORTS_HOTPLUG_CPU if CONFIG_CPU_BIG_ENDIAN

The problem is the 'CONFIG_' prefix for 'CPU_BIG_ENDIAN'.  The item is
always off since the prefix does not work as we are in a Kconfig file.
Hence, the if-statement never evaluates to true.

It can be fixed by simply removing the 'CONFIG_' prefix.

I detected this commit with ./scripts/checkkconfigsymbols.py.  Commit
b1a3f243485f ("checkkconfigsymbols.py: make it Git aware") added support
to check (and compare) undefined Kconfig symbols in Git commits.

Kind regards,
 Valentin
