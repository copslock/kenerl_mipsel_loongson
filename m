Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 20:55:15 +0200 (CEST)
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:38655 "EHLO
        lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014840AbbCaSzOMaR71 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 20:55:14 +0200
Received: from [192.168.10.109] ([83.160.161.190])
        by smtp-cloud2.xs4all.net with ESMTP
        id AJv61q00546mmVf01Jv7Po; Tue, 31 Mar 2015 20:55:08 +0200
Message-ID: <1427828108.2408.73.camel@x220>
Subject: Re: [PATCH V2 3/3] pinctrl: Add Pistachio SoC pin control driver
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>
Date:   Tue, 31 Mar 2015 20:55:08 +0200
In-Reply-To: <CAL1qeaHg2oLbnxCmk_TaxRMYA6vM8cfgUeLk=i7Q5b1CJfS9LQ@mail.gmail.com>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
         <1427757416-14491-4-git-send-email-abrestic@chromium.org>
         <1427789415.2408.45.camel@x220>
         <CAL1qeaG70_42p8r9ogHxMv2h-yx_TENYV_gZbX1wQMhqSaiFpg@mail.gmail.com>
         <1427826015.2408.63.camel@x220>
         <CAL1qeaHg2oLbnxCmk_TaxRMYA6vM8cfgUeLk=i7Q5b1CJfS9LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46665
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

Hi Andrew,

On Tue, 2015-03-31 at 11:37 -0700, Andrew Bresticker wrote:
> I have no immediate plans to make this a module, but since the changes
> to make it buildable as a module have no overhead (at least I think
> they don't!) I'd prefer to leave them in for consistency and to
> eliminate any need for these changes in the future.

The people reading the code or reviewing the patch might wonder, just
like I did, about the mismatch between the code and the Kconfig symbol.

Dead code - even if it's easily dealt with during the build - shouldn't
be added without a clear benefit. And I don't think consistency or doing
now what might be done in the future bring enough benefits.

> I'll leave it up to LinusW though.

Right, it's Linus decision.

Thanks,


Paul Bolle
