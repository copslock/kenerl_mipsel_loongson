Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 23:47:20 +0200 (CEST)
Received: from lb3-smtp-cloud6.xs4all.net ([194.109.24.31]:53741 "EHLO
        lb3-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008094AbbFBVrQ0qxLk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 23:47:16 +0200
Received: from [192.168.10.106] ([83.160.161.190])
        by smtp-cloud6.xs4all.net with ESMTP
        id bZn81q00D46mmVf01ZnAAt; Tue, 02 Jun 2015 23:47:11 +0200
Message-ID: <1433281628.2361.93.camel@x220>
Subject: Re: [PATCH 3/4] mips: make loongsoon serial driver explicitly
 modular
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Date:   Tue, 02 Jun 2015 23:47:08 +0200
In-Reply-To: <1433276168-21550-4-git-send-email-paul.gortmaker@windriver.com>
References: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
         <1433276168-21550-4-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Tue, 2015-06-02 at 16:16 -0400, Paul Gortmaker wrote:
> +static void __init serial_exit(void)

s/__init/__exit/

> +{
> +	platform_device_unregister(&uart8250_device);
> +}
> +module_exit(serial_exit);


Paul Bolle
