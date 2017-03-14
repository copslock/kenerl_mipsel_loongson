Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 22:22:04 +0100 (CET)
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:38383
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991129AbdCNVV52J-hP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 22:21:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bEz8syaWIXqFcZES7BD7Bz5VHyT60XzAYUZvent5DWE=;
 b=g+jlCKQCOaN/gvsJy0oz6fuWkIeh08C75/WXY7ACRVzCxb7G5agOVQYlMXQygPmjcJ1ideVbVvOVaqTxInyRr0a0wzbsFGEfQ8g11uWssu592qhfwUBzFhQtNQ6FP58woLHaCsvfAeH53HEOCuiF43pzQpydGKS+tFITGdBJue4=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Tue, 14 Mar 2017 21:21:48 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/5] MIPS: BPF: JIT fixes and improvements.
Date:   Tue, 14 Mar 2017 14:21:39 -0700
Message-Id: <20170314212144.29988-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0003.namprd07.prod.outlook.com (10.162.96.13) To
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144)
X-MS-Office365-Filtering-Correlation-Id: 764170ce-1aaf-4a72-b652-08d46b202034
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;3:0hFQYjrAmms3IS4xW/2OZvTTtnaaSRZI2LSN4OdWJyxPfIP47dSQaiKFSfA81U8jjOC3KWHNeHbIxWqeW+jLRhjRI1lZ2ozuWkIMAwuv/H1KCBRcmzThsqQJcyhz4sP4Ki0yKhsfEZsVuYp4TPhUcj7EBWaVHhKKvUprf2QJ+r8WUv/DZHRHF5Dl4enfs1+lXl7AdI+GTFmXRgC1fgcnryjyvn6ZGmshGCfO9n86ifrMcnoZpc0c8Z3eLftXkunZa7rN3n1hZDMypyZ4az89sg==;25:YwvfVFZxd02+spxVORSASpzlqn/iqqfU/VHNyN8ncRK0mEAkYrZ1NaEDEUSkEs5mRMPq1ujxWditZ3VbPCddY777Ciw2oT3nHD0mK1ONptH4vrWF2Kp/LJAi1YtCBqRYRZXSDByjj8ZIi6tK6imRqvJtTTgvm1HH2gGcursTzFQ1lpJvFD9UmEQS2daDo0QIKRUn0MGBHwYM+MFMCg2RU1r2ss5bSbLYC4QF6jFFPsZQrgFBVaMuV9wqko5JAyptExQVIAxmrUIFc5Jo3lcG3yI4iKfGEsckaLgfCnbUVFx52HtoqdQPWIkKxlu0MkNmSGKmUjo/XMMp86jTQXDOrfGpmgpNQMUWuG8gF6dP5f6MncDgymQzxkqABahX631yaA7JDQIkSxm/J+cnZDWLwVbeNIS2zqOCv3vkF4G4f2FEswvtuUwzFDZAhWBxgL8qLJMSpFYIAZl1GLOqxcAxOw==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;31:rw8MP+YqK7Ll5XisH4Syontl1dX+xa6uv65t7LUccFMpf+eUs25VFPY11xYtCfZN20MIv7H+gq9T3IQzuhq0itBco92xa6AiNXIuR8RlJXWhlUXn7s8/vqN9qRp0IrhVKWLSojx2vxGFLrNBNzNriCQgw5P+E8LV2CzKMAMABUgkOge045b6l1YIJK4HpkjZX6nJMhEQSTKTiHkyZxmxaLBJIccGS+wDQqyixyjIZ+2w5KFJKKUacroX9btzmLQv;20:eV+o0hfPvrctH3dyDZuXK638giGBoX/bqLESmO5+tWZCDxMa5L0TTb0ZouCmAWTQo55edlJ7y3BhuU2W2d/w0l7sp/DnWO7HHdOz4vIaaVpUZGquDKOof9bKLNq8ObYyyQPEI0o/76hKydy1BU2HUcwihBJZ2e+9CX7gN1HPMJiqVfF0IFzH7CTYbySlnTZoejo/XuCYt6wec7Hp12o9mUKlH0VJIn8gp/ZmV7KevQFsW+AdiSjD0b7UIKp1ATBTDXMkaYq/qVXIHz/ziDdaTDC75/s4VzFOipZNOhK3rBVuPU4sgqQMqZJiTjBZOL4M0pzvonRsN57wCYGb7L5NgnmZaJl2/gB1kRSju0nVdeE8AcQY32XxaDd7x8tVArJFacMFTijOnGYVwTcGupPFw37m3DrV5VQHXj/IS8ropNBopGfZcNUTeffH6cSXkRlkWIfKrzj6LJjajFtYdsen/gCMxrrVlHxV84eUOiHjGttmsn85qnGxgIXN73zny5dO
X-Microsoft-Antispam-PRVS: <BL2PR07MB24203706288DF63940BA46EB97240@BL2PR07MB2420.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123558025)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:BL2PR07MB2420;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;4:DnzY0+QmV89ADH2aBDX9OD0u/4NS17RgdDQME8bSNEZheQzun7H4E42QiLEjOIprbOF3OZHEXL2w2lqQhGpC8xrSg952hGJ+tazDcCyBjpsd8ybGd0cnQjuQ2gQCe68PWjv/WZ779iTlA1V+oP5Yj4SUcOtpgOjVZDh7vgq2nsECptikJnoYj8moX1NJrnwngI00pt7KeueCDqWVvAqXpjc7Ve36a0W93rScxQ0VJfUDK8RzgBH1SxUQO0SV3aAHcp7Dmzz/XD+ld3eX0j/hVbdKylWUQAe8fwOajuKtpHw1SxVRvy+L1E7sZK12Za6PFD/xYlYc6m6CmmVFmYYDdWZ5SBkszi6AY+7dsHUfSP50rVA1cgc3o1OpgGFsbUMBrOX6lgqIkqiptro1Xr/q0zNkNePTfGqv3583Zdy5BK9dSQojG989oUfSqWeCKZ3LknCiJvhjdYlDvLX6LmSWt0vvcdZAVW0kjHXHkpaU1mXFiNjpdPt70I+EDrOHEqHQ6CHqwcVIYYgxcwJLLyc5jdVZPCVQIzVzZqK1M1oM0DYaY1hQJE5RmRHBh5Pka1Ja27qCXU61XFdALkV7DambHbp2Gs12/5V4gyjg55UOE+w=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(305945005)(50986999)(4326008)(36756003)(7736002)(6116002)(50226002)(3846002)(8676002)(50466002)(81166006)(5003940100001)(48376002)(54906002)(6506006)(42186005)(107886003)(38730400002)(1076002)(86362001)(25786008)(53416004)(6512007)(6486002)(33646002)(47776003)(66066001)(53936002)(2906002)(5660300001)(189998001)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2420;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;23:wuzxwAvtCaD8gx8X76gD7LlSqslBj8TOZurHH6XuTGvIPIXs2DIM0MgNtSfL+hiF5kLh+aQoTAliKpEM6JJHPvcw5NaIrqWhFEHfHMZwPV1LG6/Bem72igiHl50kPzXciVicdsTztBIPkR8R+Z/IwGjwik5mVKd04yLZbG5WXzYn5WAl7dNk6ygyJUj9m7iP8WWRe6e/OoaScL7Y+C5qFUMVBoeojVLGz19VEm1izBPhHDpOahRowCcCYXZ2CrjxsFjUBtruGNKL/MnTXUCaaEOBV24TMWYGAjpX+hRjyj5Fq0X3LiIdIayzFDGcTkLIKw3hKJwor4vwpfESiE0wdonvocUi3GP4PXctLzImKvhenAmLs4VyS9u+ilSon9Ut4b7qPu5AK2Hp65P5sSQZRYXM7ayWZhZ51+zi33ov+pEMycLogzxARCqusc1/oIqntEzGOZGJUAOKQpTsCnEEfZkTeEGnvZBqIrJG4piB460Hgm3b+2X90ww+biMH5/Eg2zMTxcR1++lYpbjxGtv9pi80xrgUjp6PInnnNy/D4rC16iCliHFykmPeOkl/U2FZPVwUpC9v3tHFc1/kAN/lzgVQYq36hQPRXeGM+ODDsRELyGaRegQgY1hX14j6yV0nKckt+Ab86lBj5p9zCuszXPs7BvgS8Zug/dar8mmumdVvjnGJecMPibDiw9GQAPkQv3uJSnOZj8GBNYFh3TVcdZ1HYGQVVpm5jd6qxJh6irsoyBiO2VNn20bbUyA/P1Itb2Q7dDbTJy03c5xJdXgGKsNKLrhazf/t+CmdDG7BSNqXP9nXwW3QggAtILBSRx9Tu12WO1JBtBObT/fno4Ku9CJr/eL6reYZrVBqhXYXFhrvhwVpWY3T57deby2jHc2j
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;6:4gQ/qKjY03NQoDnylkt1PrktJzNOH5tVUJLxq6UqmWkILkgEHHGjrdCeAeXOQ9Alg1JQ16iYVCtHafKP2E4P8+ZIBUXezeKL461mUN/9Zs64IY1yPfVUwx+jI5byfKvJeQH0dxqLl8zYZzFzzbNdPiR2ixZfZVfYzJMXazE68b5zYuvs+j2e/prSSj+CV8h4UzRIoT3o9DZfD60fgKfCDlrHlQFy1bI6/EfE27YaSfFXMzAF4jK/iRjC6gSgkRlHC8mefz7zFfa9bv+5+6QCZ7UYQBzJLb47za1eQI0DQSjxIdR38bpr19dGPtdF8ilOAwzkkQRkIEnn3lIrxeGvUZsPwzqhhSSmTqCWW4q2YHiio+zQQfU4RH30IhpyAPde364NqnKf5AR2T51nmrO4Cw==;5:vOEBW1LNWz0vQq94ug3b25v/y4+dzw/0yS5P2HN9ScvVvdl6cSQFdrVFDkKvYUG5Fj0rCI7EYEl2q0hUZe2ZHjT91p0JDevFGilLQoBiXRVcviJPWDJX4yzkp3Pcs/Jk5f0MDvk5EyPYrHnLXM+esg==;24:pDtDxdSyTkb1EHQWM8l1E+wr329g4jvf6cMmZMNQThL8V0OPZoJIb3np9m/Y9vd+8EHuSp59kXM3kw+Rr3iljc0/NFikB719hszrP76eBR4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;7:DqPHVYIxZ6xTR6Rtnz9ffCaT2KJvRgGPFnxEyh7g13APzd4ussVBjvJ8rFqc8Nk4YMOYlhlDQgRE4yULdxL60o4gTjyc16DxSb1ZKLz1h2z/el4Y6foL9IXH9BQsRYB1oJDBbo6cJkz7rc2PWwJfPfW9ctkKKHei/NXxtEEU0CNHEgegRFdEoNYy9IwKQY3pelJfXcYEKSoNissDN9tAjQe8SNrMY+mEz+pduEedpvK+WdUMWk9aZkKLKOzHtmC61tu6ttaUSLm8LDKV3SZ4kiKzjVNj87yGZoLq1H/8F3SlOf3PoiMHipEKnhFWfgeDKas4P+AbBS2wW36UR86q9Q==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 21:21:48.2345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2420
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Changes from v1:

  - Use unsigned access for SKF_AD_HATYPE

  - Added three more patches for other problems found.


Testing the BPF JIT on Cavium OCTEON (mips64) with the test-bpf module
identified some failures and unimplemented features.

With this patch set we get:

     test_bpf: Summary: 305 PASSED, 0 FAILED, [85/297 JIT'ed]

Both big and little endian tested.

We still lack eBPF support, but this is better than nothing.

David Daney (5):
  MIPS: uasm:  Add support for LHU.
  MIPS: BPF: Add JIT support for SKF_AD_HATYPE.
  MIPS: BPF: Use unsigned access for unsigned SKB fields.
  MIPS: BPF: Quit clobbering callee saved registers in JIT code.
  MIPS: BPF: Fix multiple problems in JIT skb access helpers.

 arch/mips/include/asm/uasm.h |  1 +
 arch/mips/mm/uasm-mips.c     |  1 +
 arch/mips/mm/uasm.c          |  3 ++-
 arch/mips/net/bpf_jit.c      | 41 +++++++++++++++++++++++++++++++----------
 arch/mips/net/bpf_jit_asm.S  | 23 ++++++++++++-----------
 5 files changed, 47 insertions(+), 22 deletions(-)

-- 
2.9.3
