Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 20:20:23 +0200 (CEST)
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:42315 "EHLO
        lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008743AbbCaSUWR2PoN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 20:20:22 +0200
Received: from [192.168.10.109] ([83.160.161.190])
        by smtp-cloud2.xs4all.net with ESMTP
        id AJLD1q00146mmVf01JLEGc; Tue, 31 Mar 2015 20:20:15 +0200
Message-ID: <1427826015.2408.63.camel@x220>
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
Date:   Tue, 31 Mar 2015 20:20:15 +0200
In-Reply-To: <CAL1qeaG70_42p8r9ogHxMv2h-yx_TENYV_gZbX1wQMhqSaiFpg@mail.gmail.com>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
         <1427757416-14491-4-git-send-email-abrestic@chromium.org>
         <1427789415.2408.45.camel@x220>
         <CAL1qeaG70_42p8r9ogHxMv2h-yx_TENYV_gZbX1wQMhqSaiFpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46659
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

On Tue, 2015-03-31 at 09:56 -0700, Andrew Bresticker wrote:
> On Tue, Mar 31, 2015 at 1:10 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > The patch adds a mismatch between the Kconfig symbol (a bool) and the
> > code (which suggests that a modular build is also possible).
> 
> Nearly all of the pinctrl drivers (with the exception of qcom and
> intel) are like this.

Could be, I didn't check. Perhaps copy and pasting is to blame. (Copy
and pasting appears to me a sensible way to start writing a new driver).

> They use a bool Kconfig symbol but they are
> written so that they could be built as a module in the future.

Did I miss a comment or a remark in the commit explanation that explains
this? Anyhow, if that modular future is not expected to be the near
future, can you perhaps carry these lines in a branch called, say
pinctrl-modular?

Thanks,


Paul Bolle
